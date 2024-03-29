-- copy current path in form of filename:linenr
local vim = vim
vim.api.nvim_create_user_command("YankPath", function()
	local f = vim.call("expand", "%:p"):gsub("^" .. vim.call("expand", "~"), "~")
	local loc = vim.fn.fnameescape(f .. ":" .. vim.fn.getcurpos()[2])
	vim.fn.setreg("+", loc)
	vim.fn.setreg("*", loc)
	print(loc)
end, {})

vim.keymap.set("n", "yp", ":YankPath<cr>")
