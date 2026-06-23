local M = {}

local win_name = require('tabby.feature.win_name')

---@deprecated use require('tabby.feature.win_name').get(winid, { mode = 'relative' })
---@param winid number
---@return string filename
function M.relative(winid)
  return win_name.get(winid, { mode = 'relative' })
end

---@deprecated use require('tabby.feature.win_name').get(winid, { mode = 'tail' })
---@param winid number
---@return string filename
function M.tail(winid)
  return win_name.get(winid, { mode = 'tail' })
end

---@deprecated use require('tabby.feature.win_name').get(winid, { mode = 'shorten' })
---@param winid number
---@return string filename
function M.shorten(winid)
  return win_name.get(winid, { mode = 'shorten' })
end

---@deprecated use require('tabby.feature.win_name').get(winid, { mode = 'unique' })
---@param winid number
---@return string filename
function M.unique(winid)
  return win_name.get(winid, { mode = 'unique' })
end

return M
