-- copy current path in form of filename:linenr
function _G.yankpath()
	local f = vim.call("expand", "%:p"):gsub('^' .. vim.call("expand", "~"), "~")
	local loc = vim.fn.fnameescape(f .. ":" .. vim.fn.getcurpos()[2])
  vim.fn.setreg('+', loc)
  vim.fn.setreg('*', loc)
  print(loc)
end
