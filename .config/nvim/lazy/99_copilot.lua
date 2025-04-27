if true then
    return
end

-- print("not executed")

local hostname = vim.uv.os_gethostname()

-- if hostname ~= "txxx-nix" and hostname ~= "home" then
-- 	return
-- end
--
vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<c-f>", 'copilot#accept("\\<cr>")', {
	expr = true,
	replace_keycodes = false,
})

vim.keymap.set("i", "<c-f>", "<plug>(copilot-accept-line)")

-- Fix for copilot not working with nvim 0.11
-- TODO: remove after copilot.vim update
vim.lsp.start_client = vim.lsp.start

vim.defer_fn(function()
	vim.cmd.packadd("copilot.vim")
	vim.cmd([[
        call copilot#Init()
    ]])
end, 50)
