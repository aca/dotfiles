-- DEBUG
local vim = vim

if vim.env.VIM_DISABLE_LSP == "1" then
    return
end

-- vim.lsp.set_log_level("DEBUG")

vim.cmd.packadd("nvim-lspconfig")
-- vim.cmd.packadd("mason.nvim")
-- vim.cmd.packadd("mason-lspconfig.nvim")
vim.cmd.packadd("lsp_signature.nvim")
vim.cmd.packadd("neodev.nvim")
vim.cmd.packadd("nvim-vtsls")
-- vim.cmd.packadd "pylance"

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
-- local lume = require("lib/lume")
local util = require("lspconfig/util")

require("neodev").setup({})

-- null_ls.setup {
--     sources = {
--         null_ls.builtins.code_actions.gitsigns,
--     }
-- }

local border = {
    { "🭽", "FloatBorder" },
    { "▔", "FloatBorder" },
    { "🭾", "FloatBorder" },
    { "▕", "FloatBorder" },
    { "🭿", "FloatBorder" },
    { "▁", "FloatBorder" },
    { "🭼", "FloatBorder" },
    { "▏", "FloatBorder" },
}

-- LSP settings (for overriding per client)
local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

local rightAlignFormatFunction = function(diagnostic)
    local line = diagnostic.lnum
    local line_length = vim.api.nvim_strwidth(vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1] or "")
    local lwidth = vim.api.nvim_get_option("columns")
    local msg_length = vim.api.nvim_strwidth(diagnostic.message)
    local splen = lwidth - line_length - msg_length - 6
    local sp = string.rep(" ", splen)

    if string.find(diagnostic.message, "declared but its value is never read") then
        return ""
    end

    return string.format("%s» %s", sp, diagnostic.message)
end

vim.diagnostic.config({
    virtual_text = { prefix = "", format = rightAlignFormatFunction, spacing = 0, update_in_insert = true },
})

vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
        vim.diagnostic.hide()
        vim.diagnostic.show()
    end,
})

-- capabilities [[
-- https://github.com/hrsh7th/cmp-nvim-lsp/blob/b4251f0fca1daeb6db5d60a23ca81507acf858c2/lua/cmp_nvim_lsp/init.lua#L23

-- TMP: https://github.com/neovim/neovim/issues/23291
local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.tbl_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

local lsp_signature = require("lsp_signature")

-- local on_attach = function(client, bufnr)
--     lsp_signature.on_attach({
--         fix_pos = true,
--     }, bufnr)
-- end

-- configs.emmet = {
--     default_config = {
--         cmd = { "bash", "-c", "ts-node ~/src/github.com/aca/emmet-ls/src/server.ts --stdio" },
--         -- cmd = {"node", "~/src/github.com/aca/emmet-ls/out/server.js", "--stdio"},
--         -- filetypes = { "typescriptreact" },
--         root_dir = function()
--             return vim.loop.cwd()
--         end,
--     }
-- }

-- local lspconfig = require("lspconfig")
-- lspconfig.emmet.setup {
--     init_options = {
--       jsx = {
--         options = {
--           ["markup.attributes"] = { className = "class" },
--         },
--       },
--     }
-- }

-- local dev_name = "gohelper"
-- if vim.fn.executable(dev_name) == 1 then
--     configs.dev = {
--         default_config = {
--             cmd = { dev_name },
--             filetypes = { "raku" },
--             root_dir = function()
--                 return vim.loop.cwd()
--             end,
--             settings = {},
--         }
--     }
--
--     lspconfig.dev.setup {
--         capabilities = capabilities,
--         on_attach = on_attach,
--     }
-- end

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
-- end

-- lspconfig.elvish.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     settings = gopls_settings,
-- })

-- require("mason").setup()
-- require("mason-lspconfig").setup()

-- require("mason-lspconfig").setup_handlers({
--     function(server_name) -- default handler (optional)
--         lspconfig[server_name].setup({
--             capabilities = capabilities,
--             on_attach = on_attach,
--         })
--     end,
--
--     ["emmet_ls"] = function()
--         lspconfig.emmet_ls.setup({
--             init_options = {
--                 jsx = {
--                     options = {
--                         ["markup.attributes"] = { className = "class" },
--                     },
--                 },
--             },
--         })
--     end,
--
--     ["denols"] = function()
--         lspconfig.denols.setup({
--             on_attach = on_attach,
--             root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
--         })
--     end,
--
--     ["yamlls"] = function()
--         lspconfig.yamlls.setup({
--             yaml = {
--                 keyOrdering = false,
--             },
--         })
--     end,
--
--     ["lua_ls"] = function()
--         lspconfig.lua_ls.setup({
--             settings = {
--                 Lua = {
--                     completion = {
--                         callSnippet = "Replace",
--                     },
--                 },
--             },
--         })
--     end,
--
--     ["tailwindcss"] = function()
--         lspconfig.tailwindcss.setup({
--             capabilities = capabilities,
--             on_attach = on_attach,
--             filetypes = lume.filter(lspconfig.tailwindcss.document_config.default_config.filetypes, function(x)
--                 return x ~= "markdown"
--             end),
--         })
--     end,
--
--     ["vtsls"] = function()
--         require("lspconfig.configs").vtsls = require("vtsls").lspconfig
--         lspconfig.vtsls.setup({
--             capabilities = capabilities,
--             on_attach = on_attach,
--             root_dir = lspconfig.util.root_pattern("package.json"),
--             single_file_support = false,
--             -- settings = {
--             --     codeActionsOnSave = {
--             --         ["source.organizeImports.ts"] = true,
--             --     },
--             -- },
--             -- commands = {
--             --     OrganizeImports = {
--             --         function()
--             --             local params = {
--             --                 command = "_typescript.organizeImports",
--             --                 arguments = {
--             --                     vim.api.nvim_buf_get_name(0),
--             --                 },
--             --                 title = "",
--             --             }
--             --             vim.lsp.buf.execute_command(params)
--             --         end,
--             --     },
--             -- },
--         })
--     end,
--
--     -- ["tsserver"] = function()
--     --     lspconfig.tsserver.setup({
--     --         capabilities = capabilities,
--     --         on_attach = on_attach,
--     --         root_dir = lspconfig.util.root_pattern("package.json"),
--     --         single_file_support = false,
--     --         settings = {
--     --             codeActionsOnSave = {
--     --                 ["source.organizeImports.ts"] = true,
--     --             },
--     --         },
--     --         commands = {
--     --             OrganizeImports = {
--     --                 function()
--     --                     local params = {
--     --                         command = "_typescript.organizeImports",
--     --                         arguments = {
--     --                             vim.api.nvim_buf_get_name(0),
--     --                         },
--     --                         title = "",
--     --                     }
--     --                     vim.lsp.buf.execute_command(params)
--     --                 end,
--     --             },
--     --         },
--     --     })
--     -- end,
--
--     -- ["gopls"] = function()
--     --     lspconfig.gopls.setup({
--     --         single_file_support = true,
--     --         capabilities = capabilities,
--     --         on_attach = on_attach,
--     --         settings = gopls_settings,
--     --     })
--     -- end,
-- })

if vim.fn.executable("deno") == 1 then
    lspconfig.denols.setup({
        capabilities = capabilities,
        -- single_file_support = true,
        handlers = handlers,
        on_attach = on_attach,
        root_dir =lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        -- root_dir = function()
        --     root = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
        --     vim.print(root())
        --     return root
        -- end,
    })
end

if vim.fn.executable("pyright") == 1 then
    lspconfig.pyright.setup({
        -- cmd = require("pylance"),
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
end

if vim.fn.executable("vtsls") == 1 then
    lspconfig.vtsls.setup({
        capabilities = capabilities,
        single_file_support = false,
        handlers = handlers,
        on_attach = on_attach,
    })
end

if vim.fn.executable("clangd") == 1 then
    lspconfig.clangd.setup({
        capabilities = capabilities,
        single_file_support = true,
        handlers = handlers,
        on_attach = on_attach,
    })
end

if vim.fn.executable("gopls") == 1 then
    lspconfig.gopls.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
        single_file_support = true,
        handlers = handlers,
        on_attach = on_attach,
        settings = {
            gopls = {
                ["ui.completion.usePlaceholders"] = true,
                allExperiments = true,
                ["formatting.gofumpt"] = true,
                analyses = {
                    unusedparams = false,
                },
                staticcheck = true,
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
            },
        },
    })
end

local diagnostics_active = true
vim.api.nvim_create_user_command("ToggleDiagnostic", function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end, {})

vim.cmd("LspStart")
