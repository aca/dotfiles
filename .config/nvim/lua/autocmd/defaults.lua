local nvim_create_autocmd = vim.api.nvim_create_autocmd

-- set commentstring to '#' by default
nvim_create_autocmd({ "BufWinEnter", "BufAdd" }, {
	callback = function()
		if vim.bo.filetype == "" then
			vim.bo.commentstring = "# %s"
		elseif vim.bo.filetype == "elvish" then
			vim.bo.commentstring = "# %s"
		end
	end,
})

-- nvim_create_autocmd("CursorHold", {
-- 	group = group,
-- 	pattern = { "*.md" },
-- 	command = "startinsert",
-- })

-- nvim_create_autocmd("TermOpen", {
-- 	-- group = group,
-- 	pattern = { "*" },
-- 	command = "startinsert",
-- })

-- ??? 
-- nvim_create_autocmd("QuickFixCmdPost", {
--   command = "cgetexpr cwindow"
-- })

-- nvim_create_autocmd("QuickFixCmdPost", {
--   command = "cgetexpr setlocal ft=qf"
-- })

-- https://github.com/neovim/nvim-lspconfig/issues/115
-- autocmd BufWritePre *.go :silent! lua vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*.ts" },
-- 	callback = function()
--         vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.api.nvim_buf_get_name(0)}})
--          -- vim.lsp.buf.code_action({ context = { only = { "_typescript.organizeImports" } }, apply = true })
-- 	end,
-- })
