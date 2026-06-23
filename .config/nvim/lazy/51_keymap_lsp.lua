
vim.keymap.set("n", ";d", function()
	local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
	if #vim.diagnostic.get(0, { lnum = lnum }) > 0 then
		vim.diagnostic.open_float()
	else
		vim.diagnostic.setloclist()
	end
end)
