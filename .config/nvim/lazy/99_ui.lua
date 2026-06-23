vim.cmd.packadd("mini.nvim")

vim.cmd.packadd("visual-whitespace.nvim")
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
	vim.cmd.packadd("base16-nvim")
	vim.cmd.packadd("rasmus.nvim")
	vim.cmd.packadd("lush.nvim")
	vim.cmd.packadd("zenbones.nvim")
end)
