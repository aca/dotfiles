local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"

-- if getcwd() != $HOME . "/src/zettels"
--   let g:loaded_compe_tabnine = 1
-- endif

-- vim.opt.completeopt = {"menu", "menuone", "noselect"}
-- menuone,noselect,menu

--  compe
vim.g.loaded_compe_ultisnips = 1
vim.g.loaded_compe_path = 1
-- vim.g.loaded_compe_buffer = 1
vim.g.loaded_compe_tabnine = 1
vim.g.loaded_compe_luasnip = 1
vim.g.loaded_compe_snippets_nvim = 1
vim.g.loaded_compe_omni = 1
vim.g.loaded_compe_vim_lsc = 1
vim.g.loaded_compe_lamp = 1
vim.g.loaded_compe_spell = 1
vim.g.loaded_compe_tags = 1
vim.g.loaded_compe_treesitter = 1
vim.g.loaded_compe_emoji = 1
vim.g.loaded_compe_nvim_lua = 1
vim.g.loaded_compe_calc = 1


-- LSP
-- https://github.com/hrsh7th/cmp-nvim-lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = false
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
})

lspconfig.tsserver.setup {capabilities = capabilities} -- Need typescript installed to use for javascript project
lspconfig.gopls.setup {capabilities = capabilities}
-- lspconfig.hls.setup {capabilities = capabilities}
-- lspconfig.racket_langserver.setup{ capabilities = capabilities; }
lspconfig.bashls.setup{ capabilities = capabilities; }
lspconfig.vimls.setup { capabilities = capabilities; }
-- lspconfig.cssls.setup{ capabilities = capabilities; }
-- lspconfig.dockerls.setup{ capabilities = capabilities; }
-- lspconfig.html.setup{ capabilities = capabilities; }
lspconfig.jsonls.setup { capabilities = capabilities; }
lspconfig.yamlls.setup { capabilities = capabilities; }
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

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.call("vsnip#jumpable", {1}) == 1 then
        return t "<Plug>(vsnip-jump-next)"
    elseif vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    else
        local next_char = vim.api.nvim_eval("strcharpart(getline('.')[col('.') - 1:], 0, 1)")
        if next_char == '"' or next_char == ")" or next_char == "'" or next_char == "]" or next_char == "}" then
            return t "<Right>"
        end
        return t "<Tab>"
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

require('cmp_nvim_lsp').setup {}
local cmp = require'cmp'
cmp.setup {
  -- You should change this example to your chosen snippet engine.
  snippet = {
    expand = function(args)
      -- You must install `vim-vsnip` if you set up as same as the following.
      vim.fn['vsnip#anonymous'](args.body)
    end
  },

  completion = {
    -- completeopt = 'menu,menuone,noselect',
    completeopt = 'menu,menuone,noinsert',
  },

    -- You must set mapping.
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      })
    },

  -- You should specify your *installed* sources.
  sources = {
    { name = 'nvim_lsp' },
    { name = 'calc' },
    { name = 'vsnip' }
  },
}


-- require "compe".setup {
--     enabled = true,
--     debug = false,
--     preselect = "disable",
--     min_length = 1,
--     -- -- throttle_time = ... number ...;
--     -- -- source_timeout = ... number ...;
--     -- -- incomplete_delay = ... number ...;
--     allow_prefix_unmatch = true,
--     documentation = true,
--     --
--     source = {
--         path = true,
--         buffer = true,
--         vsnip = true,
--         vim_dadbod_completion = true,
--         tabnine = true,
--         -- tmux = true;
--         nvim_lsp = true
--         -- spell = true,
--         -- omni = true;
--         -- calc = true;
--         -- nvim_lua = { ... overwrite source configuration ... };
--     }
-- }
