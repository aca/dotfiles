-- Organize Imports on save
-- vim.api.nvim_create_autocmd({"BufLeave"}, {
--     pattern = { "*.go" },
--     callback = function()
--         -- this is async
--         -- vim.lsp.buf.code_action({ apply = true, filter = function(action) return action.title == "Organize Imports" end })
--         local params = vim.lsp.util.make_range_params(nil, nil)
--         -- params.context = { only = { "source.organizeImports" } } -- not sure this works
--         local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
--         for _, res in pairs(result or {}) do
--             for _, r in pairs(res.result or {}) do
--                 if r.kind == "source.organizeImports" then
--                     vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
--                     return
--                 end
--             end
--         end
--     end,
-- })

-- https://github.com/neovim/nvim-lspconfig/issues/115
vim.api.nvim_create_autocmd({"InsertLeave"}, {
    pattern = { "*.go" },
    callback = function()
        -- this runs in async
        vim.lsp.buf.code_action({ apply = true, filter = function(action) return action.title == "Organize Imports" end })
    end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "*.go",
--     callback = function()
--         vim.o.expandtab = false
--     end,
-- })
