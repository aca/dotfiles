vim.cmd([[
  packadd neoscroll.nvim
]])

require("neoscroll").setup({
    -- mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    mappings = {'<C-u>', '<C-d>'},
})
