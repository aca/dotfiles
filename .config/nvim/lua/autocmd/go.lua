-- Organize Imports on save
-- NOTES: this is simple but it's async, error when vim exits.
-- Make sure buffer completes code actions and exit.
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
        params.context = { only = { "source.organizeImports" } } -- not sure this works
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.kind == "source.organizeImports" then
                    if r.edit then
                        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
                    else
                        vim.lsp.buf.execute_command(r.command)
                    end
                end
            end
        end
    end,
})


vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go" },
    callback = function()
        local params = vim.lsp.util.make_range_params(nil, "utf-16")
        params.context = { only = { "source.organizeImports" } } -- not sure this works
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.kind == "source.organizeImports" then
                    if r.edit then
                        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
                    else
                        vim.lsp.buf.execute_command(r.command)
                    end
                end
            end
        end
    end,
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "*.go",
  callback = function()
      vim.o.expandtab = false
  end,
})
