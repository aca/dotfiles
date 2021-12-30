-- copy current path in form of filename:linenr
vim.api.nvim_add_user_command("YankPath", function(msg)
	local f = vim.call("expand", "%:p"):gsub("^" .. vim.call("expand", "~"), "~")
	local loc = vim.fn.fnameescape(f .. ":" .. vim.fn.getcurpos()[2])
	vim.fn.setreg("+", loc)
	vim.fn.setreg("*", loc)
	print(loc)
end, {})
