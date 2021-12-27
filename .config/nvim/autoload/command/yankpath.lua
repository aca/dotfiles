-- copy current path in form of filename:linenr
function _G.yankpath()
	local fp = vim.call("expand", "%:p")
	fp = fp:gsub(vim.call("expand", "~"), "~")

	local curpos = vim.fn.getcurpos()
	if fp == "" then
		return
	end

	print(fp .. ":" .. curpos[2])
	vim.cmd("let @+=" .. "'" .. fp .. ":" .. curpos[2] .. "'")
	vim.cmd("let @*=" .. "'" .. fp .. ":" .. curpos[2] .. "'")
end
