-- print("not executed")

local hostname = vim.uv.os_gethostname()

if hostname ~= "home" and hostname ~= "txxx-nix" and hostname ~= "sm-a556e" then
	return
end

vim.g.copilot_no_tab_map = true
vim.g.copilot_proxy_strict_ssl = false

vim.keymap.set("i", "<c-f>", 'copilot#Accept("\\<cr>")', {
	expr = true,
	replace_keycodes = false,
})

-- vim.keymap.set("i", "<c-f>", "<plug>(copilot-accept-line)")

-- Fix for copilot not working with nvim 0.11
-- TODO: remove after copilot.vim update

vim.defer_fn(function()
	vim.cmd.packadd("copilot.vim")
	vim.cmd([[
        call copilot#Init()
    ]])
end, 50)
