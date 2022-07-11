local group = vim.api.nvim_create_augroup("_defaults", { clear = true })
local nvim_create_autocmd = vim.api.nvim_create_autocmd

-- set commentstring to '#' by default
nvim_create_autocmd({ "BufWinEnter", "BufAdd" }, {
	group = group,
	callback = function()
		if vim.bo.filetype == "" then
			vim.bo.commentstring = "# %s"
		elseif vim.bo.filetype == "elvish" then
			vim.bo.commentstring = "# %s"
		end
	end,
})

-- mkdir on save
nvim_create_autocmd("BufWritePre", {
	group = group,
	callback = function()
		local dir = vim.fn.expand("%:p:h", _, _)
		local match = string.find(dir, "://")
		if match ~= nil then
			return
		end
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

-- if there's no other window but quickfix close vim
nvim_create_autocmd("WinEnter", {
	group = group,
	pattern = { "*" },
	command = 'au WinEnter * if winnr(\'$\') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif',
})

nvim_create_autocmd("TermOpen", {
	group = group,
	pattern = { "*" },
	command = "startinsert",
})

nvim_create_autocmd("TextYankPost", {
	group = group,
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank()
	end,
})

nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = { "lua/init.lua" },
	callback = function()
		vim.api.nvim_command("!just build")
	end,
})

-- nvim_create_autocmd("QuickFixCmdPost", {
--   group = group,
--   command = "cgetexpr cwindow"
-- })
--
-- nvim_create_autocmd("QuickFixCmdPost", {
--   group = group,
--   command = "cgetexpr setlocal ft=qf"
-- })
