-- NOTES: mark delete not working
-- https://github.com/chentoast/marks.nvim/issues/13
-- vim.cmd.packadd("marks.nvim")
-- require("marks").setup({
--   default_mappings = false,
--   mappings = {
--     -- set_next = "m,",
--     next = "m]",
--     prev = "m[",
--     -- delete_line = "dm",
--     toggle = "m;",
--     -- delete_bookmark = "dm",
--     -- preview = "m:",
--     -- set_bookmark0 = "m0",
--     -- prev = false -- pass false to disable only this default mapping
--   }
-- })

-- Ma: go to mark a, replace native 'a
vim.keymap.set("n", "M", "'")
