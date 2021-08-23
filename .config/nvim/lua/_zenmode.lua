-- folke/zen-mode.nvim

vim.cmd([[
  packadd zen-mode.nvim
  nnoremap <silent> <bslash>z :ZenMode<CR>
]])

require("zen-mode").setup {
  window = {
          number = true,
  },
  plugins = {
      gitsigns = { enabled = true },
    },
}