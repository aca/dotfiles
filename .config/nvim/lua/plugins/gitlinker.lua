-- local vim = vim
--
-- vim.cmd.packadd("plenary.nvim")
-- vim.cmd.packadd("gitlinker.nvim")
--
-- vim.api.nvim_create_user_command("GBrowse", function()
--     require("gitlinker").link({action = require("gitlinker.actions").clipboard})
--     require("gitlinker").link({action = require("gitlinker.actions").system})
-- end, {
--     range = true,
-- })
--
-- vim.api.nvim_create_user_command("Gbrowse", function()
--     require("gitlinker").link({action = require("gitlinker.actions").clipboard})
--     require("gitlinker").link({action = require("gitlinker.actions").system})
-- end, {
--     range = true,
-- })
--
-- -- vim.keymap.set(
-- --     { 'n', 'x' },
-- --     '<leader>go',
-- --     '<cmd>lua require("gitlinker").link({action = require("gitlinker.actions").clipboard})<cr>',
-- --     { desc = "Copy git link to clipboard" }
-- -- )
--
-- vim.keymap.set(
--     { 'n', 'x' },
--     '<leader>gb',
--     function()
--         require("gitlinker").link({action = require("gitlinker.actions").system})
--     end,
--     { desc = "Copy git link to clipboard" }
-- )
--
-- require('gitlinker').setup({
--   mapping = {
--     ["<leader>go"] = {
--       action = require("gitlinker.actions").clipboard,
--       desc = "Copy git link to clipboard",
--     },
--     ["<leader>xg"] = {
--       action = require("gitlinker.actions").system,
--       desc = "Open git link in default browser",
--     },
--   },
--
-- })
