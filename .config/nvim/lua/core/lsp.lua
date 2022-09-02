-- DEBUG
-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)
local lspconfig = require("lspconfig")
-- local util = require("lspconfig/util")
-- local configs = require("lspconfig/configs")
require("lsp-format").setup {}

local rightAlignFormatFunction = function(diagnostic)
    local line = diagnostic.lnum
    local line_length = vim.api.nvim_strwidth(vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1] or "")
    local lwidth = vim.api.nvim_get_option("columns")
    local msg_length = vim.api.nvim_strwidth(diagnostic.message)
    local splen = lwidth - line_length - msg_length - 7
    local sp = string.rep(" ", splen)

    if string.find(diagnostic.message, "declared but its value is never read") then
        return ""
    end

    return string.format("%s» %s", sp, diagnostic.message)
end

vim.diagnostic.config({
    virtual_text = { prefix = "", format = rightAlignFormatFunction, spacing = 0, update_in_insert = true },
})

-- this fix rightalign
-- vim.api.nvim_create_autocmd("VimResized", {
--     callback = function()
--         vim.diagnostic.hide()
--         vim.diagnostic.show()
--     end,
-- })

-- capabilities [[
-- https://github.com/hrsh7th/cmp-nvim-lsp/blob/b4251f0fca1daeb6db5d60a23ca81507acf858c2/lua/cmp_nvim_lsp/init.lua#L23
local capabilities = vim.lsp.protocol.make_client_capabilities()
local completionItem = capabilities.textDocument.completion.completionItem
completionItem.snippetSupport = true
completionItem.preselectSupport = true
completionItem.insertReplaceSupport = true
completionItem.labelDetailsSupport = true
completionItem.deprecatedSupport = true
completionItem.commitCharactersSupport = true
completionItem.tagSupport = { valueSet = { 1 } }
completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}

local on_attach = function(client, bufnr)
    local resolved_capabilities = client.server_capabilities
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    if resolved_capabilities.goto_definition == true then
        vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
    end

    if resolved_capabilities.document_formatting == true then
        vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    end

    require("illuminate").on_attach(client)
end

if vim.fn.executable("emmet-ls") == 1 then
    lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "html", "css" },
    })
end

lspconfig.pyright.setup({
    cmd = require("pylance"),
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        python = {
            analysis = {
                diagnosticSeverityOverrides = {
                    reportUnusedClass = "none",
                    reportUnusedImport = "none",
                    reportUnusedVariable = "none",
                    reportDuplicateImport = "none",
                },
            },
        },
    },
})

-- configs.lsp_dev = {
-- default_config = {
--     cmd = {"ts-node", "/Users/rok/src/github.com/aca/lsp-dev/server.ts", "--stdio"},
--     filetypes = {"text", "markdown", "go"},
--     root_dir = function()
--         return vim.loop.cwd()
--     end,
--     settings = {}
--   }
-- }
-- lspconfig.lsp_dev.setup {}

local gopls_settings = {
    gopls = {
        allExperiments = true,
        ["formatting.gofumpt"] = true,
        -- ["ui.documentation.hoverKind"] = "Structured",
        analyses = {
            unusedparams = false,
        },
        staticcheck = true,
    },
}

-- if vim.fn.executable("gopls") == 1 then
--     lspconfig.gopls.setup({
--         capabilities = capabilities,
--         on_attach = function(client, bufnr)
--             require "lsp-format".on_attach(client)
--             on_attach(client, bufnr)
--         end,
--         settings = gopls_settings,
--     })
-- end

-- lspconfig.elvish.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     settings = gopls_settings,
-- })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
    ["sumneko_lua"] = function()
        local luadev = require("lua-dev")
        lspconfig.sumneko_lua.setup(luadev.setup({}))
    end,

    ["gopls"] = function()
        lspconfig.gopls.setup(
            {
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    -- require "lsp-format".on_attach(client)
                    on_attach(client, bufnr)
                end,
                settings = gopls_settings,
            }
        )
    end,
})

-- for _, server in ipairs(lsp_installer.get_installed_servers()) do
-- 	if server.name == "sumneko_lua" then
-- 		local luadev = require("lua-dev").setup({})
-- 		lspconfig.sumneko_lua.setup(luadev)
-- 	elseif server.name == "gopls" then
-- 		lspconfig.gopls.setup({
-- 			capabilities = capabilities,
-- 			on_attach = on_attach,
-- 			settings = gopls_settings,
-- 		})
-- 	elseif server.name == "emmet_ls" then
-- 		lspconfig.emmet_ls.setup({
-- 			capabilities = capabilities,
-- 			on_attach = on_attach,
-- 			filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
-- 		})
--
-- 		-- elseif server.name == "tsserver" then
-- 		--     require("typescript").setup({
-- 		--         server = vim.tbl_deep_extend("force", server:get_default_options(), {
-- 		--         capabilities = capabilities,
-- 		--         on_attach = on_attach,
-- 		--         settings = gopls_settings,
-- 		--
-- 		--         }
-- 		--       )
-- 		--     })
-- 	else
-- 		lspconfig[server.name].setup({
-- 			capabilities = capabilities,
-- 			on_attach = on_attach,
-- 		})
-- 	end
-- end

local diagnostics_active = true
vim.api.nvim_create_user_command("ToggleDiagnostic", function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end, {})

-- this is required, as lsp is lazy loaded
vim.cmd([[ :LspStart ]])
