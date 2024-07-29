local string = require('string')
local os = require("os")
local io = require("io")
local table = require("table")

local res, uv = pcall( function() return require("uv_native") end)
if res then 
  local timer = require("timer")
end

-- copied from penlight. 
-- true if identical
function deepcompare(t1,t2,ignore_mt,eps)
  local ty1 = type(t1)
  local ty2 = type(t2)
  if ty1 ~= ty2 then
    return false
  end    
  -- non-table types can be directly compared
  if ty1 ~= 'table' then
    if ty1 == 'number' and eps then
      return abs(t1-t2) < eps
    end
    return t1 == t2
  end
  -- as well as tables which have the metamethod __eq
  local mt = getmetatable(t1)
  if not ignore_mt and mt and mt.__eq then
    return t1 == t2
  end
  for k1,v1 in pairs(t1) do
    local v2 = t2[k1]
    if v2 == nil or not deepcompare(v1,v2,ignore_mt,eps) then
      return false
    end
  end
  for k2,v2 in pairs(t2) do
    local v1 = t1[k2]
    if v1 == nil or not deepcompare(v1,v2,ignore_mt,eps) then
      return false
    end
  end
  return true
end

-- need this for luvit SIGPIPE inf-loop bug workaround  

function mprpc_init_conn(conn)
  conn.super_on = conn.on -- replace superclass "on" func..
    
  conn.doLog = false

  if not conn._pendingWriteRequests then -- in MOAI and other luasocket environments
    conn._pendingWriteRequests = 0
  end
  
  conn.packetID = 0
  conn.roundTripFuncID = 1

  conn.callCount = 0
  conn.recvBytes = 0
  conn.sendBytes = 0

  conn.recvbuf = ""
  function conn:log(...)
    if self.doLog then print(...) end
  end

  conn.doSelfTest = false

  conn.packetID = 0
  conn.waitfuncs = {}

  conn.tmpwbufs = {}
  
  conn.rpcfuncs = {}
  function conn:on(evname,fn)
    if evname == "data" then
      error("MP need data event!")
    elseif evname == "complete" or evname == "end" or evname == "error" then
      self:super_on(evname,function()
          fn()
          if self.parentServer then
            self.parentServer:clean(self)
          end
        end)
      self:log("added default callback:", evname)
    else -- rpcs
      self.rpcfuncs[evname] = fn
      self:log("added rpc func:", evname )
      print("added rpc func:", evname )      
    end
  end
  -- cb can be nil
  function conn:call(meth,arg,cb)
      
    if type(arg) ~= "table" then 
      return self:emit(meth,arg) -- fallback to super class' emit function
    end
    if type(meth) ~= "string" then error("method name required") end
    
    local t = { 1, meth, arg }
    
    if cb then
      t[4] = self.roundTripFuncID
      self.waitfuncs[ self.roundTripFuncID ] = cb
      self.roundTripFuncID = self.roundTripFuncID + 1
    end
    if self.last_call_id and ( meth == self.last_call_method .. "Result" or meth == self.last_call_method .. "_result" )  then
      t[4] = self.last_call_id 
      self.last_call_id = nil
    end

    local packed = self.rpc.mp.pack(t)


    if self.doSelfTest then
      local nread,resulttbl = self.rpc.mp.unpack(packed)
      local correct = deepcompare(resulttbl,t)
      if not correct then
        self:log( "deepcompare failed. NaN is included in the argument? sending any way." )
        if pp then pp("argument:", t) end
      end
    end
    
    local payloadlen = #packed
    local lenpacked = self.rpc.mp.pack(payloadlen)
    if self.doSelfTest then
      local nread,resultval = self.rpc.mp.unpack(lenpacked)
      assert(resultval == payloadlen, "selftestpackedlen")
    end
    
    local tosend = lenpacked .. packed

    self.packetID = self.packetID + 1
    self:log("meth:", meth, "sending actual data bytes:", #tosend, "payloadlen:", payloadlen, "packetID:", self.packetID )

    if self._pendingWriteRequests == 0 then
      self.tmpwbufs = {}
    end
    
    if self._pendingWriteRequests then
      table.insert( self.tmpwbufs, tosend )
    end
    self._pendingWriteRequests = self._pendingWriteRequests + 1
    self.sendBytes = self.sendBytes + #tosend    
    self:write( tosend, function(e)
        if e and e.code == "EFAULT" then
          error( "fatal:EFAULT")
        end
        self._pendingWriteRequests = self._pendingWriteRequests - 1
      end)
  end

  function conn:close()
    if uv then
      uv.close( self._handle)
    end    
  end
  
  conn:super_on("data", function (chunk)
      conn.lastAliveAt = os.time()
      conn.recvbuf = conn.recvbuf .. chunk
      conn:log("data. chunklen:", string.len(chunk), " recvbuf:", string.len(conn.recvbuf), "alive:", conn.lastAliveAt )
      if conn.autoPollMessage then
        conn:pollMessage()
      end                            
    end)
  function conn:pollMessage(continueFunc )
    local offset=1

    while true do
      if continueFunc and continueFunc() == false then
        break
      end
      if #conn.recvbuf == 0 then
        break
      end
      if #conn.recvbuf == offset-1 then
        self:log( "fully consumed" )
        break
      end

      local pcallret, nread,res
      local envelopebytes = string.sub(conn.recvbuf,offset,offset+8)  -- 8 bytes are enough for payloadlen

      pcallret, nread,res = pcall( function()
          return conn.rpc.mp.unpack(envelopebytes) -- 8 bytes are enough for payloadlen
        end )
      if not pcallret or not nread then
        break  -- no data, so next loop.
      end

      local payloadlen = res
      local bufleft = ( #conn.recvbuf - offset + 1 ) - nread

--      self:log("mprpc env!: offset:", offset, "payloadlen:", payloadlen, "envelopelen:", nread, "#recvbuf:", #conn.recvbuf, "bufleft:",bufleft, "packetID:", self.packetID )
      if payloadlen == nil then
        self:log("payloadlen is nil, need more data")
        break
      end      
      if payloadlen <= 0 then
        self:log( "payloadlen:", payloadlen, "<=0" )
        return true
      end      
      if bufleft < payloadlen then
        self:log("bufleft<payloadlen.",bufleft,"<",payloadlen)
        break
      end


      self.packetID = self.packetID + 1

      offset = offset + nread

      local toread = string.sub(conn.recvbuf,offset,offset+payloadlen-1)  -- should never throws exception
      if #toread == 0 then
        self:log("format error?")
        return false
      end      
      if string.byte( toread,1,1) ~= 0x93 then
        self:log( "not a msgpack map:" .. string.byte(toread,1,1) )
        return false
      end
      
      nread,res = conn.rpc.mp.unpack(toread)
      if nread ~= payloadlen then
        self:log( "nread ~= payloadlen.. nread:" .. nread .. " payloadlen:" .. payloadlen )
        return false
      end
      self.recvBytes = self.recvBytes + nread
      
      if type(res) ~= "table" or res[1] ~= 1 or type(res[2]) ~= "string" or type(res[3]) ~= "table" then
        print("rpc format error. offset:", offset, "res:", res, "data:", strdump(toread) )
        return false
      else
        local meth = res[2]
        local arg = res[3]
        local call_id = res[4]
        
        local f = self.rpcfuncs[meth]
        if not f and not self.waitfuncs[call_id] then
          self:log("receiver func not found:",meth )
        else
          if call_id then
            local wf = self.waitfuncs[call_id]
            if wf then
              self:log( "waitfunc found. call_id:", call_id )
              wf(arg)
              self.waitfuncs[call_id]=nil
            else
              self:log( "waitfunc not found. call_id:", call_id )
              self.last_call_id = call_id
              self.last_call_method = meth
              self:log("last_call_id set:", self.last_call_id)
              f(arg)              
            end
          else
            if self.exceptionHandler then
              xpcall( function() f(arg) end, self.exceptionHandler )
            else
              f( arg )
            end
          end                                     
        end
        self.callCount = self.callCount + 1
      end
      offset = offset + nread
    end
    if offset > 1 then
      self.recvbuf = string.sub( self.recvbuf, offset)
    else
    end
    return true
  end
end

function mprpc_createServer(self,cb)
  assert(self.net and self.mp )

  local sv
  sv = self.net.createServer( function(client)
      client.lastAliveAt = os.time()
      mprpc_init_conn(client)
      client.parentServer = sv
      client.rpc = self
      local addr = client:address().address
      sv:regAddr(addr)
      print("new connection from ", addr)      
      cb(client)
      table.insert( sv.clients, client )    
    end)
  sv.clients = {}
  sv.cliAddrs = {}

  
  sv:on("error", function (err)  p("ERROR", err) end)

  function sv:regAddr(a)
    if not self.cliAddrs[a] then
      self.cliAddrs[a] = 1
    else
      self.cliAddrs[a] = self.cliAddrs[a] + 1
    end
  end

  function sv:clean(cli)
    for i,v in ipairs(self.clients) do
      if v == cli then
        table.remove( self.clients, i )
        break
      end
    end   
  end
  
  function sv:broadcast(meth,arg)
    for i,cli in ipairs(self.clients) do
      cli:call(meth,arg)
    end  
  end
  function sv:scan(callback)
    for _,cli in ipairs(self.clients) do
      callback(cli)
    end    
  end
  


  sv.clientTimeout = 10
  
  timer.setInterval(1000, function()
      -- connection timeout
      local nt = os.time() 
      local toclean = {}
      for i,v in ipairs(sv.clients) do
        v:poll()
        if v.lastAliveAt and v.lastAliveAt < (nt - sv.clientTimeout ) then
          -- this causes luvit crash (0.3):    v:shutdown()
          table.insert( toclean,v )
          if v.close then 
            v:close()
          elseif uv then 
            uv.close( v._handle )
          end
          v:log("client timeout! closing.", v )
        end                               
      end
      for i,v in ipairs(toclean)do
        sv:clean(v)
      end
    end)
  
  return sv
end

function mprpc_createConnection(self,port,ip,cb)
  assert(self.net and self.mp and cb)
  local conn
  conn = self.net.createConnection( port, ip, cb )
  mprpc_init_conn(conn)
  conn.rpc = self
  return conn
end

function mprpc_create_with_net_and_mp(net,mp)
  if not mp or not mp.pack or not mp.unpack then
    error( "msgpack is required")
  end
  
  local mod = {}
  mod.net = net
  mod.mp = mp
  mod.createServer = mprpc_createServer
  mod.createConnection = mprpc_createConnection
  return mod
end

mprpc = {
  create = mprpc_create_with_net_and_mp
}

return mprpc