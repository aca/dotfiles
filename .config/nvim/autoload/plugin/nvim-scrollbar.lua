-- if vim.g._minimal then return end

vim.cmd([[
  packadd nvim-scrollbar
]])

require("scrollbar").setup({
    handle = {
        color = "#161821",
    },
})
