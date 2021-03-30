local nvim_lsp = require'lspconfig'
local configs = require'lspconfig/configs'
local vim = vim
-- Log Level
vim.lsp.set_log_level("trace")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local arch = "Linux"; if vim.g._uname == 'mac' then arch = "macOS" end

if os.getenv("USER") ~= "rok" then return end

--[[ local saga = require 'lspsaga'
saga.init_lsp_saga() ]]


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 4,
      prefix = '--',
    },
  }
)

nvim_lsp.gopls.setup{ capabilities = capabilities; }
nvim_lsp.racket_langserver.setup{ capabilities = capabilities; }
nvim_lsp.bashls.setup{ capabilities = capabilities; }
nvim_lsp.vimls.setup { capabilities = capabilities; }
nvim_lsp.cssls.setup{ capabilities = capabilities; }
nvim_lsp.dockerls.setup{ capabilities = capabilities; }
nvim_lsp.html.setup{ capabilities = capabilities; }
nvim_lsp.jsonls.setup { capabilities = capabilities; }
nvim_lsp.yamlls.setup { capabilities = capabilities; }
nvim_lsp.clangd.setup{ capabilities = capabilities; }
nvim_lsp.rust_analyzer.setup { capabilities = capabilities; }
nvim_lsp.tsserver.setup{ capabilities = capabilities; }
-- nvim_lsp.pyright.setup{
--   on_attach = on_attach;
--   -- capabilities = capabilities;
-- }

require 'pylance'
nvim_lsp.pylance.setup{
  settings = {
    python = {
      analysis = {
        -- typeCheckingMode = "strict"
      }
    }
  };
  capabilities = capabilities;
}

local sumneko_root_path = vim.fn.expand('$HOME/src/github.com/sumneko/lua-language-server')
nvim_lsp.sumneko_lua.setup{
  cmd = { sumneko_root_path .. "/bin/".. arch .. "/lua-language-server", "-E", sumneko_root_path .. "/main.lua"};
  settings = {
      Lua = {
          runtime = {
              -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
          },
          diagnostics = {
              globals = {'vim'},
          },
          workspace = {
              library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              },
          },
      },
  },
}

-- configs.korean_ls = {
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
configs.neuron_ls = {
default_config = {
    -- cmd = {'neuron', 'lsp'};
    cmd = {'neuron-language-server'};
    filetypes = {'markdown'};
    root_dir = function()
      return vim.loop.cwd()
    end;
    settings = {};
  };
}
nvim_lsp.neuron_ls.setup{}

-- emmet language server
--[[ configs.emmet_ls = {
  default_config = {
    cmd = {'emmet-ls', '--stdio'};
    filetypes = {'html', 'css'};
    root_dir = function()
      return vim.loop.cwd()
    end;
    settings = {};
  };
}
nvim_lsp.emmet_ls.setup{} ]]

-- vim.api.nvim_set_keymap(
--   'i', '<Tab>',
--   'pumvisible() ? "<C-n>" : v:lua.check_backspace() ? "<Tab>" : "<C-r>=compe#complete()<CR>"',
--   { noremap=true, expr=true }
-- )
