-- NOTES: https://github.com/altermo/ultimate-autopair.nvim

vim.pack.add({ { src = 'https://github.com/windwp/nvim-autopairs.git' } })
local npairs = require("nvim-autopairs")

npairs.setup({
	check_ts = true,
	disable_in_visualblock = true,
	disable_in_macro = true,
    -- map_cr = false,
})
