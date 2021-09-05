-- https://github.com/ruifm/gitlinker.nvim

vim.cmd 'packadd gitlinker.nvim'

require"gitlinker".setup({
  mappings = "gy"
})
