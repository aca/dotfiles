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
	cmd = { "gopls" },
	root_markers = { "go.mod" },
	filetypes = { "go" },
	config = {
		settings = {
			gopls = {
				hints = {
					rangeVariableTypes = true,
					parameterNames = true,
					constantValues = true,
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					functionTypeParameters = true,
				},
			},
		},
	},
}

vim.lsp.config.luals = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
}

vim.lsp.enable({ "gopls", "luals" })
