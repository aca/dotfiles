-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)

vim.pack.add({ { src = 'https://github.com/neovim/nvim-lspconfig.git' } })

vim.lsp.enable({
	"gopls",
    "jsonls",
    -- "zuban",
	"lua_ls",
	"vtsls",
	"teal_ls",
	-- "agl",
	"ols",
    "racket_langserver",
	"zls",
	"bashls",
    "rust_analyzer",
    -- "json",
	"clangd",
	-- "ty",
	-- "basedpyright",
})

