-- DEBUG
local vim = vim

if vim.env.VIM_DISABLE_LSP == "1" then
	return
end

-- https://www.reddit.com/r/neovim/comments/180fmw5/add_this_to_make_nvmcmp_docs_look_way_better_in/
-- vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
-- 	contents = vim.lsp.util._normalize_markdown(contents, {
-- 		width = vim.lsp.util._make_floating_popup_size(contents, opts),
-- 	})
--
-- 	vim.bo[bufnr].filetype = "markdown"
-- 	vim.treesitter.start(bufnr)
-- 	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
--
-- 	return contents
-- end

vim.cmd.packadd("nvim-lspconfig")
-- vim.cmd.packadd("mason.nvim")
-- vim.cmd.packadd("mason-lspconfig.nvim")
vim.cmd.packadd("lsp_signature.nvim")
vim.cmd.packadd("neodev.nvim")
vim.cmd.packadd("nvim-vtsls")
-- vim.cmd.packadd("nvim-navic") -- TODO: replace with dropbar.nvim
-- vim.cmd.packadd "pylance"

local lspconfig = require("lspconfig")
-- local configs = require("lspconfig.configs")
-- local lume = require("lib/lume")
-- local util = require("lspconfig/util")

require("neodev").setup({})

-- local border = {
-- 	{ "🭽", "FloatBorder" },
-- 	{ "▔", "FloatBorder" },
-- 	{ "🭾", "FloatBorder" },
-- 	{ "▕", "FloatBorder" },
-- 	{ "🭿", "FloatBorder" },
-- 	{ "▁", "FloatBorder" },
-- 	{ "🭼", "FloatBorder" },
-- 	{ "▏", "FloatBorder" },
-- }

local handlers = {}

-- handlers = {
-- 	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
-- 	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
-- 	["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 		signs = false,
-- 	}),
-- }

-- local rightAlignFormatFunction = function(diagnostic)
-- 	local line = diagnostic.lnum
-- 	local line_length = vim.api.nvim_strwidth(vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1] or "")
-- 	local lwidth = vim.api.nvim_get_option_value("columns", {})
-- 	local numberwidth = vim.api.nvim_get_option_value("numberwidth", {})
-- 	local msg_length = vim.api.nvim_strwidth(diagnostic.message)
-- 	local splen = lwidth - line_length - msg_length - numberwidth - 6
-- 	local sp = string.rep(" ", splen)
--
-- 	-- if string.find(diagnostic.message, "declared but its value is never read") then
-- 	-- 	return ""
-- 	-- end
--
-- 	return string.format("%s» %s", sp, diagnostic.message)
-- end

-- NOTES: Deprecated
-- -- Highlight line number instead of having icons in sign column https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#highlight-line-number-instead-of-having-icons-in-sign-column
-- for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
-- 	vim.fn.sign_define("DiagnosticSign" .. diag, {
-- 		text = "",
-- 		texthl = "DiagnosticSign" .. diag,
-- 		linehl = "",
-- 		numhl = "DiagnosticSign" .. diag,
-- 	})
-- end

vim.diagnostic.config({
	-- virtual_text = { prefix = "", format = rightAlignFormatFunction, spacing = 0, update_in_insert = true },
	virtual_text = {
		format = function(diagnostic)
			local lines = vim.split(diagnostic.message, "\n")
            local msg = lines[1]

			-- if diagnostic.severity == vim.diagnostic.severity.HINT then
			--     return ""
			-- end

			local line = diagnostic.lnum
			local line_length = vim.api.nvim_strwidth(vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1] or "")
			local window_width = vim.api.nvim_get_option_value("columns", {})
			local number_width = vim.api.nvim_get_option_value("numberwidth", {})

            local maxwidth = window_width - number_width - line_length - 3

            -- get lua string length
            local len = vim.api.nvim_strwidth(msg)
            if len > maxwidth then
                msg = string.sub(msg, 1, maxwidth - 2) .. ".."
            end

			-- 	local msg_length = vim.api.nvim_strwidth(diagnostic.message)
			-- 	local splen = lwidth - line_length - msg_length - numberwidth - 6
			-- 	local sp = string.rep(" ", splen)

			-- if string.find(lines[1], "declared but its value is never read") then
			-- 	return ""
			-- end

			return msg
		end,
		severity = vim.diagnostic.severity.ERROR,
		--       hl_mode = "replace",
		virt_text_pos = "right_align",
		-- virt_text_win_col = 40,
		virt_text_hide = true,
		-- suffix = " ",
	},
	signs = {
		text = {
			-- do not use signcolumn
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		linehl = {
			-- [vim.diagnostic.severity.ERROR] = "ErrorMsg",
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
	-- virtual_text = false,
	-- float = {
	-- 	source = "always", -- Or "if_many"
	-- },
	-- float = { border = "rounded" },
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
-- vim.tbl_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

local on_attach = function(client, bufnr)
    -- vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
	require("lsp_signature").on_attach({
		fix_pos = true,
	}, bufnr)
end

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

-- vim.lsp.set_log_level("DEBUG")

-- if vim.fn.executable("korean-ls") == 1 then
--     configs.korean_ls = {
--         default_config = {
--             cmd = { "korean-ls", "--stdio" },
--             filetypes = { "markdown" },
--             root_dir = function()
--                 return vim.loop.cwd()
--             end,
--             settings = {},
--         }
--     }
--     lspconfig.korean_ls.setup {
--         capabilities = capabilities,
--         on_attach = on_attach,
--     }
-- end

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
		-- single_file_support = false,
		-- handlers = handlers,
		on_attach = on_attach,
		root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
		init_options = {
			lint = true,
			unstable = true,
			suggest = {
				imports = {
					hosts = {
						["https://deno.land"] = true,
						["https://cdn.nest.land"] = true,
						["https://crux.land"] = true,
					},
				},
			},
		},
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

-- if vim.fn.executable("my") == 1 then
-- 	lspconfig.lua_ls.setup({
-- 		capabilities = capabilities,
-- 		single_file_support = false,
-- 		handlers = handlers,
-- 		on_attach = on_attach,
-- 	})
-- end
--

-- NOTES: configuration does not work as expected, and it is not worth it.
-- language server itself sucks, rely on dadbod completion
-- if vim.fn.executable("sqls") == 1 then
-- 	lspconfig.sqls.setup({
-- 		on_attach = on_attach,
-- 		settings = {
-- 			sqls = {
-- 				connections = {
-- 					{
-- 						driver = "sqlite3",
-- 						-- dataSourceName = "root:root@tcp(127.0.0.1:13306)/world",
-- 						-- dataSourceName = vim.env.SQLS_SQLITE_DB_FILE,
-- 						dataSourceName = "example.db",
-- 					},
-- 				},
-- 			},
-- 		},
-- 	})
-- end
-- if vim.env.SQLS_SQLITE_DB_FILE ~= "" then
-- end

if vim.fn.executable("lua-language-server") == 1 then
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		single_file_support = false,
		handlers = handlers,
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
			},
		},
	})
end

if vim.fn.executable("kotlin-language-server") == 1 then
	lspconfig.kotlin_language_server.setup({
		capabilities = capabilities,
		single_file_support = false,
		handlers = handlers,
		on_attach = on_attach,
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

if vim.fn.executable("sourcekit-lsp") == 1 then
	lspconfig.sourcekit.setup({
		capabilities = capabilities,
		single_file_support = true,
		handlers = handlers,
		on_attach = on_attach,
	})
end

if vim.fn.executable("jdt-language-server") == 1 then
	lspconfig.jdtls.setup({
		capabilities = capabilities,
		single_file_support = true,
		handlers = handlers,
		on_attach = on_attach,
		cmd = { "jdt-language-server" },
	})
end

if vim.fn.executable("zls") == 1 then
	lspconfig.zls.setup({
		capabilities = capabilities,
		single_file_support = true,
		handlers = handlers,
		on_attach = on_attach,
	})
end

if vim.fn.executable("clangd") == 1 then
	local clangd_capabilities = vim.deepcopy(capabilities)
	clangd_capabilities.offsetEncoding = "utf-8"

	lspconfig.clangd.setup({
		capabilities = clangd_capabilities,
		single_file_support = true,
		handlers = handlers,
		on_attach = on_attach,
	})
end

if vim.fn.executable("nixd") == 1 then
	lspconfig.nixd.setup({
		capabilities = capabilities,
		single_file_support = true,
		handlers = handlers,
		on_attach = on_attach,
	})
end

if vim.fn.executable("rust-analyzer") == 1 then
	lspconfig.rust_analyzer.setup({
		capabilities = capabilities,
	})
end

if vim.fn.executable("templ") == 1 then
	lspconfig.templ.setup({
		capabilities = capabilities,
	})
end

if vim.fn.executable("gopls") == 1 then
	lspconfig.gopls.setup({

        on_attach = on_attach,
		cmd = { "gopls", "-remote=auto" },
		-- cmd = { 'goplsx' },
		-- cmd = { 'gopls', '-remote=unix;/tmp/gopls-daemon-socket2' },

		capabilities = capabilities,
		root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
		-- single_file_support = true,
		-- handlers = handlers,
		-- handlers = handlers,
		-- on_attach = on_attach,
		-- settings = {
		--     gopls = {
		--         -- ["ui.completion.usePlaceholders"] = true,
		--         -- allExperiments = true,
		--         ["formatting.gofumpt"] = true,
		--         -- analyses = {
		--         --     unusedparams = false,
		--         -- },
		--         -- staticcheck = true,
		--         -- hints = {
		--         --     assignVariableTypes = true,
		--         --     compositeLiteralFields = true,
		--         --     constantValues = true,
		--         --     functionTypeParameters = true,
		--         --     parameterNames = true,
		--         --     rangeVariableTypes = true,
		--         -- },
		--     },
		-- },
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

-- Fix for bug https://github.com/neovim/neovim/issues/12970
vim.lsp.util.apply_text_document_edit = function(text_document_edit, index, offset_encoding)
	local text_document = text_document_edit.textDocument
	local buf = vim.uri_to_bufnr(text_document.uri)
	if offset_encoding == nil then
		vim.notify_once("apply_text_document_edit must be called with valid offset encoding", vim.log.levels.WARN)
	end

	vim.lsp.util.apply_text_edits(text_document_edit.edits, buf, offset_encoding)
end



vim.cmd("LspStart")
