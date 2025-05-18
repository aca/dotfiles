vim.cmd.packadd("symbols.nvim")
local r = require("symbols.recipes")

require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
	-- custom settings here
	-- e.g. hide_cursor = false
})

vim.keymap.set("n", "<leader>s", "<cmd>SymbolsToggle<CR>")
-- vim.keymap.set("n", ",S", "<cmd> SymbolsClose<CR>")
