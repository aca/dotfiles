-- vim.api.nvim_create_autocmd(‘LspAttach’, {
--     callback = function(args)
-- 	    local client = vim.lsp.get_client_by_id(args.data.client_id)
-- 	    if client and client:supports_method(‘textDocument/foldingRange’) then
-- 		    local win = vim.api.nvim_get_current_win()
-- 		    vim.wo[win][0].foldmethod = ‘expr’
-- 		    vim.wo[win][0].foldexpr = ‘v:lua.vim.lsp.foldexpr()’
-- 	    end
--     end,
-- })

vim.lsp.config.gopls = {
    cmd = {"gopls"},
    root_markers = { "go.mod" },
    filetypes = {"go"},
}

vim.lsp.enable({"gopls", "luals"})
