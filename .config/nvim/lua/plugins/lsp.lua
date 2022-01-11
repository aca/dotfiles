-- vim:foldmethod=marker foldmarker=[[,]]

-- DEBUG [[
-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)
-- ]]
-- lspcontainers.nvim [[
-- { "docker", "container", "run", "--interactive", "--rm", "--network=none", "--workdir=//(pwd)", "--volume=//(pwd)://(pwd):ro", "lspcontainers/lua-language-server:2.4.2" }
-- ]
-- init [[
vim.cmd([[ 
packadd nvim-lspconfig
packadd nvim-lsp-installer
]])

local lspconfig = require("lspconfig")
-- local util = require("lspconfig/util")
-- local configs = require("lspconfig/configs")
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

-- ]]
-- handlers [[

-- TODO: slow diagnostic update on mac
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	virtual_text = true,
-- 	signs = true,
-- 	underline = true,
-- 	update_in_insert = true,
-- })

-- ]]
-- on_attach [[
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
		-- Add this <leader> bound mapping so formatting the entire document is easier.
		-- map("n", "<leader>gq", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	end
	-- print("loaded")

	require("lsp_signature").on_attach()
end
-- ]]
-- server: gopls [[
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
-- ]]
-- server: pylance [[
local ok, pylance = pcall(require, "pylance")
if ok then
	lspconfig.pyright.setup({
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
else
	lspconfig.pyright.setup({
		cmd = pylance,
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

-- ]]
-- server: servers with installer [[
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local opts = {
		lspconfig = {
			capabilities = capabilities,
		},
		on_attach = on_attach,
	}

	if server.name == "sumneko_lua" then
		-- local runtime_path = vim.split(package.path, ";")
		-- table.insert(runtime_path, "lua/?.lua")
		-- table.insert(runtime_path, "lua/?/init.lua")
		opts = require("lua-dev").setup({
			lspconfig = {
				capabilities = capabilities,
				-- Lua = {
				-- 	runtime = {
				-- 		-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				-- 		version = "LuaJIT",
				-- 		-- Setup your lua path
				-- 		path = runtime_path,
				-- 	},
				-- 	diagnostics = {
				-- 		-- Get the language server to recognize the `vim` global
				-- 		globals = { "vim" },
				-- 	},
				-- 	workspace = {
				-- 		-- Make the server aware of Neovim runtime files
				-- 		library = vim.api.nvim_get_runtime_file("", true),
				-- 	},
				-- 	-- Do not send telemetry data containing a randomized but unique identifier
				-- 	telemetry = {
				-- 		enable = false,
				-- 	},
				-- },
			},
			on_attach = on_attach,
		})
	end
	server:setup(opts)
end)
-- ]]

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
