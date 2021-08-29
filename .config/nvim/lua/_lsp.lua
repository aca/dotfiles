local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"

-- Based on https://github.com/hrsh7th/cmp-nvim-lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = {"markdown"}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = false
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = {valueSet = {1}}
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits"
    }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true
    }
)

lspconfig.tsserver.setup {capabilities = capabilities} -- Need typescript installed to use for javascript project
lspconfig.gopls.setup {capabilities = capabilities}
-- lspconfig.hls.setup {capabilities = capabilities}
-- lspconfig.racket_langserver.setup{ capabilities = capabilities; }
lspconfig.bashls.setup {capabilities = capabilities}
-- lspconfig.vimls.setup { capabilities = capabilities; }
-- lspconfig.cssls.setup{ capabilities = capabilities; }
-- lspconfig.dockerls.setup{ capabilities = capabilities; }
-- lspconfig.html.setup{ capabilities = capabilities; }
lspconfig.jsonls.setup {capabilities = capabilities}
lspconfig.yamlls.setup {capabilities = capabilities}
-- lspconfig.rust_analyzer.setup { capabilities = capabilities; }
lspconfig.clangd.setup {capabilities = capabilities}
lspconfig.terraformls.setup {capabilities = capabilities}

-- https://www.reddit.com/r/neovim/comments/mrep3l/speedup_your_prettier_formatting_using_prettierd/
-- lspconfig.denols.setup{
--   -- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" , "json"},
--   -- filetypes = { "json", "yaml", "markdown"},
--   filetypes = { "json", "yaml"},
--   root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git", vim.fn.getcwd()),
--   settings = {
--     init_options = {
--       enable = true,
--       lint = true,
--       unstable = false
--     }
--   }
-- }

require "pylance"
lspconfig.pylance.setup {
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {}
        }
    }
}

local sumneko_root_path = vim.fn.expand("$HOME/src/github.com/sumneko/lua-language-server")
local luadev =
    require("lua-dev").setup(
    {
        -- add any options here, or leave empty to use the default settings
        lspconfig = {
            cmd = {
                sumneko_root_path .. "/bin/" .. vim.g._uname .. "/lua-language-server",
                "-E",
                sumneko_root_path .. "/main.lua"
            },
            capabilities = capabilities
        }
    }
)

lspconfig.sumneko_lua.setup(luadev)

-- configs.korean_ls = {
-- default_config = {
--     cmd = {"korean-ls", "--stdio"},
--     filetypes = {"text"},
--     root_dir = function()
--         return vim.loop.cwd()
--     end,
--     settings = {}
-- }
-- }
-- lspconfig.korean_ls.setup {}

if os.getenv("LS_KOREAN") == "on" then
    configs.korean_ls = {
        default_config = {
            cmd = {"korean-ls", "--stdio"},
            filetypes = {"text"},
            root_dir = function()
                return vim.loop.cwd()
            end,
            settings = {}
        }
    }
    lspconfig.korean_ls.setup {}
end

-- neuron language server
-- nvim_lsp.configs.neuron_ls = {
-- default_config = {
--     -- cmd = {'neuron', 'lsp'};
--     cmd = {'neuron-language-server'};
--     filetypes = {'markdown'};
--     root_dir = function()
--       return vim.loop.cwd()
--     end;
--     settings = {};
--   };
-- }
-- nvim_lsp.neuron_ls.setup{}

-- if not lspconfig.emmet_ls then
--   configs.emmet_ls = {
--     default_config = {
--       cmd = {'emmet-ls', '--stdio'};
--       filetypes = {'html', 'css'};
--       root_dir = function(fname)
--         return vim.loop.cwd()
--       end;
--       settings = {};
--     };
--   }
-- end

-- lspconfig.emmet_ls.setup{ capabilities = capabilities; }
