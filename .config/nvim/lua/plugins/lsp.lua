-- DEBUG
-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)

vim.cmd([[ 
  packadd nvim-lspconfig
  packadd nvim-lsp-installer
]])

local lspconfig = require("lspconfig")
-- local util = require("lspconfig/util")
local configs = require("lspconfig/configs")
-- ]]
-- capabilities [[
-- https://github.com/hrsh7th/cmp-nvim-lsp/blob/b4251f0fca1daeb6db5d60a23ca81507acf858c2/lua/cmp_nvim_lsp/init.lua#L23
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
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

-- TODO: slow diagnostic update on mac
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
})

local on_attach = function(client, bufnr)
    local resolved_capabilities = client.resolved_capabilities
    local api = vim.api
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    if resolved_capabilities.goto_definition == true then
        api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
    end

    if resolved_capabilities.document_formatting == true then
        api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    end
end

if vim.fn.executable("gopls") == 1 then
    lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            gopls = {
                analyses = {
                    unusedparams = false,
                },
                staticcheck = true,
            },
        },
    })
end

if vim.fn.executable("emmet-ls") == 1 then
    lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
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

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
        lspconfig = {
            capabilities = capabilities,
        },
        on_attach = on_attach,
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
    if server.name == "sumneko_lua" then
        local runtime_path = vim.split(package.path, ";")
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")
        opts = require("lua-dev").setup({
            lspconfig = {
                capabilities = capabilities,
            },
            on_attach = on_attach,
        })
        opts.settings.Lua.diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim", "wezterm" },
            disable = { "unused-function", "unused-label", "unused-vararg", "unused-local" },
        }
    end
    server:setup(opts)
end)

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
