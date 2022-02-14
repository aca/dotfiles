-- https://github.com/ruifm/gitlinker.nvim

vim.cmd([[
packadd plenary.nvim
packadd gitlinker.nvim
]])

require("gitlinker").setup({
    mappings = "yl",
})
