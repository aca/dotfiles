-- folke/zen-mode.nvim

vim.cmd([[
  packadd zen-mode.nvim
  nnoremap <silent> <bslash>z :ZenMode<CR>
]])

require("zen-mode").setup {
  plugins = {
      gitsigns = { enabled = true },
    },
}