-- vim.cmd([[
--   packadd neoscroll.nvim
-- ]])
--
-- require("neoscroll").setup({
--     -- mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
--     mappings = { "<C-u>", "<C-d>" },
-- })
--
-- require("neoscroll.config").set_mappings({
--     ["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "100" } },
--     ["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "100" } },
-- })
