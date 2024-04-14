local hostname = vim.uv.os_gethostname()

if hostname ~= "rok-toss-nix" and
    hostname ~= "root" then
    return
end
-- vim.keymap.set("i", "<C-F>", 'copilot#Accept("\\<CR>")', {
-- 	expr = true,
-- 	replace_keycodes = false,
-- })

vim.keymap.set('i', '<C-F>', '<Plug>(copilot-accept-line)')
vim.g.copilot_no_tab_map = true
vim.cmd.packadd("copilot.vim")
vim.cmd [[
call copilot#Init()
]]
