-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)

-- vim.cmd.packadd("dropbar.nvim")

vim.cmd.packadd("nvim-navic")
local navic = require("nvim-navic")
navic.setup {
    icons = {
        File          = " ",
        Module        = " ",
        Namespace     = " ",
        Package       = " ",
        Class         = " ",
        Method        = " ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = " ",
        Interface     = " ",
        Function      = " ",
        Variable      = " ",
        Constant      = " ",
        String        = " ",
        Number        = " ",
        Boolean       = " ",
        Array         = " ",
        Object        = " ",
        Key           = " ",
        Null          = " ",
        EnumMember    = " ",
        Struct        = " ",
        Event         = " ",
        Operator      = " ",
        TypeParameter = " ",
    },
    -- lsp = {
    --     auto_attach = false,
    --     preference = nil,
    -- },
    -- highlight = false,
    -- separator = " > ",
    -- depth_limit = 0,
    -- depth_limit_indicator = "..",
    -- safe_output = true,
    -- lazy_update_context = false,
    -- click = false,
    -- format_text = function(text)
    --     return text
    -- end,
}

local function setup_winbar(client, bufnr)
	-- local status_ok, method_supported = pcall(function()
	--   return client.supports_method 'textDocument/documentSymbol'
	-- end)

	-- if not status_ok or not method_supported then
	--   return
	-- end
	-- navic.attach(client, bufnr)

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
        vim.o.statusline = "»%{%v:lua.require'nvim-navic'.get_location()%}%=%f"
	end
end

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("_navic", {}),
-- 	callback = function(ctx)
-- 		if not ctx.data then
-- 			return
-- 		end
-- 		local client = vim.lsp.get_client_by_id(ctx.data.client_id)
-- 		local bufnr = ctx.buf
-- 		setup_winbar(client, bufnr)
-- 	end,
-- })













vim.cmd.packadd("nvim-lspconfig")

-- don't know why but '*' doesn't work
-- vim.lsp.config("*", {
-- 	root_markers = { ".git" },
-- })

vim.lsp.config("basedpyright", {
	root_markers = { ".git" },
})

-- vim.lsp.config('basedpyright', {
--     cmd = { "uv", "run", "basedpyright-langserver", "--stdio" },
-- })

-- lspconfig['basedpyright'].cmd = { "uv", "run", "basedpyright-langserver", "--stdio" }
-- vim.print(lspconfig['basedpyright'])
-- vim.lsp.config('basedpyright', lspconfig['basedpyright'])

vim.lsp.config["agl"] = {
	cmd = { "agl-lsp" },
	filetypes = { "agl" },
	root_markers = { ".git" },
	settings = {},
}

-- vim.lsp.config["basedpyright"].cmd = "basedpyright"

-- vim.lsp.config('json')

vim.lsp.enable({
	"gopls",
    "jsonls",
    "zuban",
	"lua_ls",
	"vtsls",
	"teal_ls",
	"agl",
	"ols",
	"zls",
	"bashls",
    "rust_analyzer",
    -- "json",
	"clangd",
	-- "ty",
	-- "basedpyright",
})

