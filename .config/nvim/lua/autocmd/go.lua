-- local group = vim.api.nvim_create_augroup("_go", { clear = true })
-- local nvim_create_autocmd = vim.api.nvim_create_autocmd

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = group,
-- 	pattern = { "*.go" },
-- 	callback = function()
-- 		vim.lsp.buf.code_action({
-- 			apply = true,
-- 			filter = function(action)
-- 				return action.title == "Organize Imports"
-- 			end,
-- 		})
-- 	end,
-- })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function()
		local params = vim.lsp.util.make_range_params(nil, "utf-16")
		params.context = { only = { "source.organizeImports" } }
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

