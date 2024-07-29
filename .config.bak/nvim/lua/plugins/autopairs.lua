-- NOTES: https://github.com/altermo/ultimate-autopair.nvim

vim.cmd("packadd nvim-autopairs")
local npairs = require("nvim-autopairs")

npairs.setup({
	check_ts = true,
	disable_in_visualblock = true,
	disable_in_macro = true,
})
