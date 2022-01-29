-- https://github.com/ruifm/gitlinker.nvim

vim.cmd([[
packadd gitlinker.nvim
packadd plenary.nvim
]])

require("gitlinker").setup({
    mappings = "gy",
})
