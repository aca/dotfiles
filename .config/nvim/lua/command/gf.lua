-- copy current path in form of filename:linenr
-- vim.api.nvim_create_user_command("GOTO", function(msg)
--     local cfile = vim.call("expand", "<cfile>")
--     if cfile:find("^https?://") then
--         print("url")
--     else
--         print("not url")
--     end
-- end, {})
--
-- vim.cmd([[
-- nnoremap gf :GOTO<cr>
-- ]])
