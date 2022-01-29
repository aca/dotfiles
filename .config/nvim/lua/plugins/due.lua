vim.cmd([[
  packadd due.nvim
]])

require("due_nvim").setup({
    pattern_start = " ",
    pattern_end = " ",
})
