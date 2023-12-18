-- -- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1011938524
local loaded, ls = pcall(require, "luasnip")
if not loaded then
    return
end

function _G._leave_snippet()
	if
		((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
		and ls.session.current_nodes[vim.api.nvim_get_current_buf()]
		and not ls.session.jump_active
	then
		ls.unlink_current()
	end
end

vim.api.nvim_create_autocmd("ModeChanged", {
	callback = function()
		_leave_snippet()
	end,
})
