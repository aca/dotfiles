vim.pack.add({ { src = 'https://github.com/echasnovski/mini.nvim.git' } })

vim.pack.add({ { src = 'https://github.com/mcauley-penney/visual-whitespace.nvim' } })
-- require("visual-whitespace").setup({
--     -- highlight = {
--     --     space = "VisualWhitespaceSpace",
--     --     tab = "VisualWhitespaceTab",
--     --     trail = "VisualWhitespaceTrail",
--     -- },
-- })

-- require("ui.statusline")
vim.o.laststatus = vim.o.laststatus
-- require("ui.lsp_diagnostics")

vim.schedule(function()
	vim.pack.add({ { src = 'https://github.com/RRethy/base16-nvim' } })
	vim.pack.add({ { src = 'https://github.com/kvrohit/rasmus.nvim.git' } })
	vim.pack.add({ { src = 'https://github.com/rktjmp/lush.nvim.git' } })
	vim.pack.add({ { src = 'https://github.com/zenbones-theme/zenbones.nvim.git' } })
end)
