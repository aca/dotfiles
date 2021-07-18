local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'    
-- require'lsp_signature'.on_attach()
-- require'aerial'.on_attach()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.tsserver.setup{ capabilities = capabilities; } -- Need typescript installed to use for javascript project
lspconfig.gopls.setup{ capabilities = capabilities; }
lspconfig.hls.setup{ capabilities = capabilities; }
-- lspconfig.racket_langserver.setup{ capabilities = capabilities; }
-- nvim_lsp.bashls.setup{ capabilities = capabilities; }
-- nvim_lsp.vimls.setup { capabilities = capabilities; }
-- nvim_lsp.cssls.setup{ capabilities = capabilities; }
-- nvim_lsp.dockerls.setup{ capabilities = capabilities; }
-- nvim_lsp.html.setup{ capabilities = capabilities; }
-- nvim_lsp.jsonls.setup { capabilities = capabilities; }
-- nvim_lsp.yamlls.setup { capabilities = capabilities; }
-- nvim_lsp.rust_analyzer.setup { capabilities = capabilities; }
lspconfig.clangd.setup{ capabilities = capabilities; }

-- https://www.reddit.com/r/neovim/comments/mrep3l/speedup_your_prettier_formatting_using_prettierd/
-- nvim_lsp.denols.setup{
--   filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" , "json"},
--   root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", ".git", vim.fn.getcwd()),
--   settings = {
--     init_options = {
--       enable = true,
--       lint = true,
--       unstable = false
--     }
--   }
-- }

require 'pylance'
lspconfig.pylance.setup{
  capabilities = capabilities; 
  settings = {
    python = {
      analysis = {
        -- typeCheckingMode = "strict"
      }
    }
  };
}

local sumneko_root_path = vim.fn.expand('$HOME/src/github.com/sumneko/lua-language-server')
local luadev = require("lua-dev").setup({
  -- add any options here, or leave empty to use the default settings
  lspconfig = {
    cmd = { sumneko_root_path .. "/bin/".. vim.g._uname .. "/lua-language-server", "-E", sumneko_root_path .. "/main.lua"};
    capabilities = capabilities;
  },
})


lspconfig.sumneko_lua.setup(luadev)

-- nvim_lsp.configs.korean_ls = {
--   default_config = {
--     cmd = {'korean-ls', '--stdio'};
--     filetypes = {'text'};
--     root_dir = function()
--       return vim.loop.cwd()
--     end;
--     settings = {};
--   };
-- }
-- nvim_lsp.korean_ls.setup{}


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

require'compe'.setup {
  enabled = true;
  debug = false;
  preselect = 'disable';
  min_length = 1;
  -- -- throttle_time = ... number ...;
  -- -- source_timeout = ... number ...;
  -- -- incomplete_delay = ... number ...;
  allow_prefix_unmatch = true;
  documentation = true;
  --
  source = {
    path = true;
    buffer = true;
    vsnip = true;
    tabnine = true;
    -- tmux = true;
    nvim_lsp = true;
    -- omni = true;
    -- calc = true;
    -- nvim_lua = { ... overwrite source configuration ... };
  };
}

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

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

