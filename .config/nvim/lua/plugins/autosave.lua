vim.cmd.packadd("auto-save.nvim")
-- -- -- https://github.com/pocco81/auto-save.nvim?tab=readme-ov-file
require("auto-save").setup({
    trigger_events = {"FocusLost"}, -- vim events that trigger auto-save. See :h events
})
--
-- vim.api.nvim_create_autocmd("FocusLost", {
--   pattern = "*",
--   callback = function()
--       print("vim leave")
--   end,
-- })
