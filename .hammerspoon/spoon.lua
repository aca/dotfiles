
function pong(data, tag)
    hs.alert.show(data)
end

server = hs.socket.server(9002, pong):receive("\n")
