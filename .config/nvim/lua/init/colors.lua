-- vim.cmd.packadd "monokai-pro.nvim"
-- require("monokai-pro").setup({
--   filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
-- })
-- vim.cmd.colorscheme "monokai-pro"

-- vim.cmd.packadd "lush.nvim"
vim.cmd [[ 
packadd zenbones.nvim
packadd lush.nvim
set termguicolors
set background=dark " or dark
" let g:zenbones_compat = 1
" colorscheme zenbones
]]

vim.cmd.packadd "mellifluous.nvim"
require'mellifluous'.setup(
{
   -- color_set = 'mellifluous'
   -- color_set = 'alduin'
   -- color_set = "mountain"
   -- color_set = "tender"
   color_set = "kanagawa_dragon"
}
)
vim.cmd.colorscheme 'mellifluous'

vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "NormalNC", {bg = "none"})
vim.api.nvim_set_hl(0, "Statusline", {bg = "#0D0D0D"})

