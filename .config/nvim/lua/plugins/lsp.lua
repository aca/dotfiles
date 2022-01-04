vim.cmd([[ packad nvim-lspconfig ]])

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local configs = require("lspconfig/configs")

-- Based on https://github.com/hrsh7th/cmp-nvim-lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- local on_attach = function(client, bufnr)
-- end

-- https://github.com/lalanikarim/nvim-config/blob/main/lsp.vim
-- local on_attach = function(client, bufnr)
--   local resolved_capabilities = client.resolved_capabilities
--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
--   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--   if resolved_capabilities.declaration then
--     buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   end
--
--   if resolved_capabilities.goto_definition then
--     buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   end
--
--   if resolved_capabilities.goto_definition == true then
--       api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
--   end
--
--   if resolved_capabilities.document_formatting == true then
--       api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
--       -- Add this <leader> bound mapping so formatting the entire document is easier.
--       map("n", "<leader>gq", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--   end
-- end

-- capabilities.textDocument.completion.completionItem.documentationFormat = {"markdown"}
-- capabilities.textDocument.completion.completionItem.preselectSupport = false
-- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
-- capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
-- capabilities.textDocument.completion.completionItem.deprecatedSupport = true
-- capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
-- capabilities.textDocument.completion.completionItem.tagSupport = {valueSet = {1}}
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--     properties = {
--         "documentation",
--         "detail",
--         "additionalTextEdits"
--     }
-- }

-- TODO: slow diagnostic update on mac
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	virtual_text = true,
-- 	signs = true,
-- 	underline = true,
-- 	update_in_insert = true,
-- })

lspconfig.tailwindcss.setup({ capabilities = capabilities }) -- Need typescript installed to use for javascript project
lspconfig.tsserver.setup({ capabilities = capabilities }) -- Need typescript installed to use for javascript project
lspconfig.emmet_ls.setup({
	capabilities = capabilities,
	cmd = { "emmet-ls", "--stdio" },
	-- cmd = { "emmetls.sh"},
})

lspconfig.gopls.setup({capabilities = capabilities})
-- lspconfig.gopls.setup({capabilities = capabilities})
-- lspconfig.gopls.setup({
-- 	capabilities = capabilities,
-- 	-- autostart = true,
-- 	-- settings = {
-- 	-- 	gopls = {
-- 	-- 		analyses = {
-- 	-- 			unusedparams = false,
-- 	-- 		},
-- 	-- 		staticcheck = true,
-- 	-- 	},
-- 	-- },
-- })

-- lspconfig.hls.setup {capabilities = capabilities}
-- lspconfig.racket_langserver.setup{ capabilities = capabilities; }
lspconfig.bashls.setup({ capabilities = capabilities })
-- lspconfig.vimls.setup { capabilities = capabilities; }
-- lspconfig.cssls.setup{ capabilities = capabilities; }
-- lspconfig.dockerls.setup{ capabilities = capabilities; }
-- lspconfig.html.setup{ capabilities = capabilities; }
-- lspconfig.jsonls.setup {capabilities = capabilities}
lspconfig.yamlls.setup({ capabilities = capabilities })
lspconfig.rust_analyzer.setup({ capabilities = capabilities })
lspconfig.clangd.setup({ capabilities = capabilities })
-- lspconfig.terraformls.setup {capabilities = capabilities}

-- https://www.reddit.com/r/neovim/comments/mrep3l/speedup_your_prettier_formatting_using_prettierd/
-- lspconfig.denols.setup({
-- 	-- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" , "json"},
-- 	-- filetypes = { "json", "yaml", "markdown"},
-- 	filetypes = { "json", "yaml" },
-- 	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git", vim.fn.getcwd()),
-- 	settings = {
-- 		init_options = {
-- 			enable = true,
-- 			lint = true,
-- 			unstable = false,
-- 		},
-- 	},
-- })

local luadev = require("lua-dev").setup({
	lspconfig = {
		cmd = require("lspcontainers").command("sumneko_lua"),
		capabilities = capabilities,
	},
})

lspconfig.sumneko_lua.setup(luadev)

-- if vim.fn.executable("docker") == 1 then
--   local runtime_path = vim.split(package.path, ";")
--   table.insert(runtime_path, "lua/?.lua")
--   table.insert(runtime_path, "lua/?/init.lua")
--   lspconfig.sumneko_lua.setup({
--     cmd = {"lua-language-server"},
--     -- cmd = require("lspcontainers").command("sumneko_lua"),
--     settings = {
--       capabilities = capabilities,
--       Lua = {
--         runtime = {
--           -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--           version = "LuaJIT",
--           -- Setup your lua path
--           path = runtime_path,
--         },
--         diagnostics = {
--           -- Get the language server to recognize the `vim` global
--           globals = { "vim" },
--         },
--         workspace = {
--           -- Make the server aware of Neovim runtime files
--           library = vim.api.nvim_get_runtime_file("", true),
--         },
--         -- Do not send telemetry data containing a randomized but unique identifier
--         telemetry = {
--           enable = false,
--         },
--       },
--     },
--   })
-- end

--[[

Custom lang servers

--]]

-- require("pylance")
-- lspconfig.pylance.setup({
-- 	capabilities = capabilities,
-- 	settings = {
-- 		python = {
-- 			analysis = {},
-- 		},
-- 	},
-- })

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

-- configs.korean_ls = {
-- default_config = {
--     cmd = {"korean-ls", "--stdio"},
--     filetypes = {"text", "markdown"},
--     root_dir = function()
--         return vim.loop.cwd()
--     end,
--     settings = {}
--   }
-- }
-- lspconfig.korean_ls.setup {}

-- if os.getenv("LS_KOREAN") == "on" then
--     configs.korean_ls = {
--         default_config = {
--             cmd = {"korean-ls", "--stdio"},
--             filetypes = {"text"},
--             root_dir = function()
--                 return vim.loop.cwd()
--             end,
--             settings = {}
--         }
--     }
--     lspconfig.korean_ls.setup {}
-- end

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

-- configs.zk = {
--   default_config = {
--     cmd = {'zk', 'lsp'},
--     filetypes = {'markdown'},
--     root_dir = function()
--       return vim.loop.cwd()
--     end,
--     settings = {}
--   };
-- }

-- lspconfig.zk.setup({ on_attach = function(client, buffer) end })

-- require "lsp_signature".setup({
--   bind = true, -- This is mandatory, otherwise border config won't get registered.
--   -- handler_opts = {
--   --   border = "rounded"
--   -- }
-- })
