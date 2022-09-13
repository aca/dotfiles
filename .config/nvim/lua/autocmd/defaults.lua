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
nvim_create_autocmd({"BufWritePre"}, {
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

-- nvim_create_autocmd("CursorHold", {
-- 	group = group,
-- 	pattern = { "*.md" },
-- 	command = "startinsert",
-- })

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

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.ts" },
	callback = function()
		local params = vim.lsp.util.make_range_params(nil, "utf-16")
		params.context = { only = { "_typescript.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end,
})
