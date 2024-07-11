local hostname = vim.uv.os_gethostname()

if hostname ~= "rok-txxx-nix" and hostname ~= "root" then
	return
end
-- vim.keymap.set("i", "<C-F>", 'copilot#Accept("\\<CR>")', {
-- 	expr = true,
-- 	replace_keycodes = false,
-- })

vim.keymap.set("i", "<C-F>", "<Plug>(copilot-accept-line)")
vim.g.copilot_no_tab_map = true
vim.cmd.packadd("copilot.vim")

local initcmd
initcmd = vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
        -- print("loading copilot")
		vim.cmd([[
            call copilot#Init()
        ]])
		vim.defer_fn(function()
			vim.api.nvim_del_autocmd(initcmd)
		end, 20)
	end,
})

-- autocmd VimEnter             * call s:MapTab() | call copilot#Init()
-- vim.cmd [[
-- call copilot#Init()
-- ]]
