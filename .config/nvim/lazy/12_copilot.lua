local hostname = vim.uv.os_gethostname()

if hostname ~= "txxx-nix" and hostname ~= "home" then
	return
end

vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<C-F>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})

vim.keymap.set("i", "<C-F>", "<Plug>(copilot-accept-line)")

vim.defer_fn(function()
	vim.cmd.packadd("copilot.vim")
	vim.cmd([[
        call copilot#Init()
    ]])
end, 50)
