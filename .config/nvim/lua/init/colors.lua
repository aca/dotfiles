-- vim.cmd.packadd "monokai-pro.nvim"
-- require("monokai-pro").setup({
--   filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
-- })
-- vim.cmd.colorscheme "monokai-pro"

-- vim.cmd.packadd "lush.nvim"
vim.cmd([[ 
packadd zenbones.nvim
packadd lush.nvim
set termguicolors
set background=dark " or dark
" let g:zenbones_compat = 1
]])

-- vim.cmd.packadd("mellifluous.nvim")
-- require("mellifluous").setup({
-- 	-- color_set = "mellifluous",
-- 	-- color_set = 'alduin'
-- 	color_set = "mountain"
-- 	-- color_set = "tender"
-- 	-- color_set = "kanagawa_dragon"
-- })

vim.cmd.colorscheme("zenwritten")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "Statusline", { bg = "#0D0D0D" })

vim.api.nvim_set_hl(0, "BufTabLineCurrent", { bg = "#0D0D0D", fg = "#d7d4d4", bold = true })
vim.api.nvim_set_hl(0, "BufTabLineActive", { bg = "#0D0D0D", fg = "#d7d4d4", italic = true })
vim.api.nvim_set_hl(0, "BufTabLineHidden", { bg = "#0D0D0D", fg = "#4e4e4e", italic = true })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#0D0D0D", fg = "#d7d4d4" })
