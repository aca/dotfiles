-- DEBUG
local vim = vim

local lume = require('lib/lume')

vim.cmd [[
    packadd nvim-lspconfig
    packadd mason.nvim
    packadd mason-lspconfig.nvim
    packadd lsp-inlayhints.nvim
    " packadd lsp-format.nvim
    packadd null-ls.nvim

    packadd neodev.nvim
]]

require("neodev").setup({})

local lspconfig = require("lspconfig")
-- local util = require("lspconfig/util")
-- local configs = require("lspconfig.configs")

-- require("lsp-format").setup {}

-- local null_ls = require("null-ls")
-- "gq" not working in markdown
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     vim.bo[args.buf].formatexpr = nil
--   end,
-- })

-- null_ls.setup {
--     sources = {
--         null_ls.builtins.code_actions.gitsigns,
--     }
-- }

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
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
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

    -- require("illuminate").on_attach(client)
    require("lsp-inlayhints").on_attach(client, bufnr)
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

-- configs.emmet = {
--     default_config = {
--         -- cmd = {"ts-node", "/home/rok/src/github.com/aca/emmet-ls/src/server.ts", "--stdio"},
--         cmd = {"node", "~/src/github.com/aca/emmet-ls/out/server.js", "--stdio"},
--         filetypes = {"css", "html"},
--         root_dir = function()
--             return vim.loop.cwd()
--         end,
--         settings = {},
--       }
-- }

-- lspconfig.emmet.setup{
--     capabilities = capabilities,
--     on_attach = on_attach,
-- }

-- configs.mzk = {
--     default_config = {
--         -- cmd = { "ts-node", os.getenv("HOME") .. "/src/github.com/aca/mdpls/src/server.ts", "--stdio" },
--         cmd = { os.getenv("HOME") .. "/src/github.com/aca/zk/zk" },
--         filetypes = { "markdown" },
--         root_dir = function()
--             return vim.loop.cwd()
--         end,
--         settings = {},
--     }
-- }
-- lspconfig.mzk.setup {
--     capabilities = capabilities,
--     on_attach = on_attach,
-- }
--
-- configs.mdpls = {
--     default_config = {
--         cmd = { "ts-node", os.getenv("HOME") .. "/src/github.com/aca/mdpls/src/server.ts", "--stdio" },
--         filetypes = { "markdown" },
--         root_dir = function()
--             return vim.loop.cwd()
--         end,
--         settings = {},
--     }
-- }
-- lspconfig.mdpls.setup {
--     capabilities = capabilities,
--     on_attach = on_attach,
-- }
--

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


-- if vim.fn.executable("deno") == 1 then
--     lspconfig.denols.setup {
--         on_attach = on_attach,
--         root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
--     }
-- end

-- P(lspconfig.tailwindcss.default_config.filetypes)
require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,

    ["denols"] = function()
        lspconfig.denols.setup {
            on_attach = on_attach,
            root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        }
    end,

    ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace"
                    }
                }
            }
        })
    end,

    ["tailwindcss"] = function()
        lspconfig.tailwindcss.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = lume.filter(lspconfig.tailwindcss.document_config.default_config.filetypes,
                function(x) return x ~= "markdown" end)
        })
    end,

    ["tsserver"] = function()
        lspconfig.tsserver.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = lspconfig.util.root_pattern("package.json"),
            single_file_support = false,
            settings = {
                codeActionsOnSave = {
                    ["source.organizeImports.ts"] = true,
                },
                -- TODO: not work
                preferences = {
                    javascript = {
                        format = {
                            tabSize = 2,
                            convertTabsToSpaces = true,
                        },
                    },
                    typescript = {
                        format = {
                            tabSize = 2,
                            convertTabsToSpaces = true,
                        },
                    },
                    typescriptreact = {
                        format = {
                            tabSize = 2,
                            convertTabsToSpaces = true,
                        },
                    },
                }
            },
            commands = {
                OrganizeImports = {
                    function()
                        local params = {
                            command = "_typescript.organizeImports",
                            arguments = {
                                vim.api.nvim_buf_get_name(0)
                            },
                            title = ""
                        }
                        vim.lsp.buf.execute_command(params)
                    end
                }
            }
        })
    end,

    ["gopls"] = function()
        local gopls_settings = {
            gopls = {
                allExperiments = true,
                ["formatting.gofumpt"] = true,
                analyses = {
                    unusedparams = false,
                },
                staticcheck = true,
            },
        }

        lspconfig.gopls.setup(
            {
                single_file_support = true,
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
vim.cmd([[:LspStart]])
