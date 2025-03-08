-- if true then
--     return
-- end

local vim = vim

if vim.env.VIM_DISABLE_LSP == "1" then
	return
end

-- vim.lsp.set_log_level("OFF")
vim.lsp.set_log_level("DEBUG")


-- diagnostic at insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- delay update diagnostics
    update_in_insert = true,
  }
)

-- vim.cmd.packadd("nvim-lsp-endhints")
-- require("lsp-endhints").setup({
-- 	-- icons = {
-- 	-- 	type = "󰜁 ",
-- 	-- 	parameter = "󰏪 ",
-- 	-- 	offspec = " ", -- hint kind not defined in official LSP spec
-- 	-- 	unknown = " ", -- hint kind is nil
-- 	-- },
-- 	label = {
-- 		padding = 1,
-- 		marginLeft = 0,
-- 		bracketedParameters = true,
-- 	},
-- 	autoEnableHints = true,
-- })

-- vim.cmd.packadd("nvim-lsp-endhints")
-- require("lsp-endhints").setup({
-- 	icons = {
-- 		type = "󰜁 ",
-- 		parameter = "󰏪 ",
-- 		offspec = " ", -- hint kind not defined in official LSP spec
-- 		unknown = " ", -- hint kind is nil
-- 	},
-- 	label = {
-- 		padding = 1,
-- 		marginLeft = 0,
-- 		bracketedParameters = true,
-- 	},
-- 	autoEnableHints = true,
-- })
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(args)
-- 		vim.lsp.inlay_hint.enable(true)
-- 		require("lsp-endhints").enable()
-- 	end,
-- })


vim.cmd.packadd("plenary.nvim")
local strdisplaywidth = require("plenary").strings.strdisplaywidth

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
local lspconfig = require("lspconfig")

-- vim.cmd.packadd("neodev.nvim")
-- require("neodev").setup({})

-- vim.cmd.packadd("nvim-vtsls")
-- local configs = require("lspconfig.configs")
-- local lume = require("lib/lume")
-- local util = require("lspconfig/util")

-- https://github.com/neovim/neovim/issues/28261#issuecomment-2130338921


local handlers = {}

-- custom right align function as `virt_text_pos = "right_align"` override original text
local rightAlignFormatFunction = function(diagnostic)
	local msg = diagnostic.message
	local line = diagnostic.lnum
	local line_length = strdisplaywidth(vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1] or "")
	local msg_length = strdisplaywidth(msg)
	-- local lwidth = vim.api.nvim_get_option_value("columns", {})
	-- local wwidth = vim.api.nvim_get_option_value("columns", {})
	-- local numberwidth = vim.api.nvim_get_option_value("numberwidth", {})
	local wininfo = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
	-- https://github.com/neovim/neovim/issues/17229
	local textoff = wininfo.textoff
	local wwidth = wininfo.width

	local sp = ""
	-- -4: -2 for minimal default spacing that i can't control, -2 for prefix
	local maxrightwidth = wwidth - textoff - line_length - 4
	if msg_length > maxrightwidth then
		msg = string.sub(msg, 1, maxrightwidth - 1) .. "…"
	else
		local splen = wwidth - textoff - line_length - msg_length - 4
		sp = string.rep(" ", splen)
	end
	return string.format("%s» %s", sp, msg)
end

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
    -- virtual_lines = true,
	virtual_text = {
		format = rightAlignFormatFunction,
		spacing = 0,
		prefix = "",
		suffix = "",
		severity = vim.diagnostic.severity.ERROR,
		-- hl_mode = "combine",
		-- virt_text_pos = "right_align",
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

-- nvim-ufo
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    -- lineFoldingOnly = true
}

local on_attach = function(client, bufnr)
	-- vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
	-- require("lsp_signature").on_attach({
	-- 	fix_pos = true,
	-- }, bufnr)
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

-- lspconfig.elvish.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     settings = gopls_settings,
-- })

--     ["tailwindcss"] = function()
--         lspconfig.tailwindcss.setup({
--             capabilities = capabilities,
--             on_attach = on_attach,
--             filetypes = lume.filter(lspconfig.tailwindcss.document_config.default_config.filetypes, function(x)
--                 return x ~= "markdown"
--             end),
--         })
--     end,

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
		-- cmd = require("pylance"),

-- if vim.fn.executable("basedpyright") == 1 then
-- 	lspconfig.basedpyright.setup({
-- 		capabilities = capabilities,
-- 		on_attach = on_attach,
-- 		settings = {
-- 			python = {
-- 				analysis = {
-- 					diagnosticSeverityOverrides = {
-- 						reportUnusedClass = "none",
-- 						reportUnusedImport = "none",
-- 						reportUnusedVariable = "none",
-- 						reportDuplicateImport = "none",
-- 					},
-- 				},
-- 			},
-- 		},
-- 	})
-- end

-- if vim.fn.executable("pylyzer") == 1 then
-- 	lspconfig.pylyzer.setup({
-- 		capabilities = capabilities,
-- 		on_attach = on_attach,
-- 		settings = {
-- 			python = {
-- 				analysis = {
-- 					diagnosticSeverityOverrides = {
-- 						reportUnusedClass = "none",
-- 						reportUnusedImport = "none",
-- 						reportUnusedVariable = "none",
-- 						reportDuplicateImport = "none",
-- 					},
-- 				},
-- 			},
-- 		},
-- 	})
-- end

-- if vim.fn.executable("lua-language-server") == 1 then
-- 	lspconfig.lua_ls.setup({
-- 		capabilities = capabilities,
-- 		single_file_support = false,
-- 		handlers = handlers,
-- 		on_attach = on_attach,
-- 		settings = {
-- 			Lua = {
-- 				diagnostics = {
-- 					-- Get the language server to recognize the `vim` global
-- 					globals = { "vim" },
-- 				},
--
-- 				hint = { enable = true },
-- 			},
-- 		},
-- 	})
-- end

-- if vim.fn.executable("kotlin-language-server") == 1 then
-- 	lspconfig.kotlin_language_server.setup({
-- 		init_options = {
-- 			storagePath = vim.fn.resolve(vim.fn.stdpath("cache")),
-- 		},
--
-- 		root_dir = function()
-- 			return vim.loop.cwd()
-- 		end,
-- 		-- capabilities = capabilities,
-- 		single_file_support = true,
-- 		-- handlers = handlers,
-- 		-- on_attach = on_attach,
-- 	})
-- end

local jsInlayHints = {
	includeInlayParameterNameHints = "all",
	includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = false,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}

if vim.fn.executable("vtsls") == 1 then
	lspconfig.vtsls.setup({
		capabilities = capabilities,
		single_file_support = false,
		handlers = handlers,
		on_attach = on_attach,
		settings = jsInlayHints,
	})
end
--
-- if vim.fn.executable("sourcekit-lsp") == 1 then
-- 	lspconfig.sourcekit.setup({
-- 		capabilities = capabilities,
-- 		single_file_support = true,
-- 		handlers = handlers,
-- 		on_attach = on_attach,
-- 	})
-- end
--
-- if vim.fn.executable("jdt-language-server") == 1 then
-- 	lspconfig.jdtls.setup({
-- 		capabilities = capabilities,
-- 		single_file_support = true,
-- 		handlers = handlers,
-- 		on_attach = on_attach,
-- 	})
-- end
--
if vim.fn.executable("ruff") == 1 then
	lspconfig.ruff.setup({
		capabilities = capabilities,
		single_file_support = true,
		handlers = handlers,
		on_attach = on_attach,
	})
end
--
--
-- if vim.fn.executable("zls") == 1 then
-- 	lspconfig.zls.setup({
-- 		capabilities = capabilities,
-- 		single_file_support = true,
-- 		handlers = handlers,
-- 		on_attach = on_attach,
-- 	})
-- end
--
-- if vim.fn.executable("vscode-css-language-server") == 1 then
-- 	lspconfig.cssls.setup({
-- 		capabilities = capabilities,
-- 		single_file_support = true,
-- 		handlers = handlers,
-- 		on_attach = on_attach,
-- 	})
-- end
-- --
-- if vim.fn.executable("vscode-html-language-server") == 1 then
-- 	lspconfig.html.setup({
-- 		capabilities = capabilities,
-- 		single_file_support = true,
-- 		handlers = handlers,
-- 		on_attach = on_attach,
-- 	})
-- end
--
-- if vim.fn.executable("vscode-json-language-server") == 1 then
-- 	lspconfig.jsonls.setup({
-- 		capabilities = capabilities,
-- 		single_file_support = true,
-- 		handlers = handlers,
-- 		on_attach = on_attach,
-- 	})
-- end
--
-- if vim.fn.executable("vscode-eslint-language-server") == 1 then
-- 	lspconfig.eslint.setup({
-- 		capabilities = capabilities,
-- 		single_file_support = true,
-- 		handlers = handlers,
-- 		on_attach = on_attach,
-- 	})
-- end

-- if vim.fn.executable("clangd") == 1 then
-- 	local clangd_capabilities = vim.deepcopy(capabilities)
-- 	clangd_capabilities.offsetEncoding = "utf-8"
--
-- 	lspconfig.clangd.setup({
-- 		capabilities = clangd_capabilities,
-- 		single_file_support = true,
-- 		handlers = handlers,
-- 		on_attach = on_attach,
-- 	})
-- end
--
-- if vim.fn.executable("nixd") == 1 then
-- 	lspconfig.nixd.setup({
-- 		capabilities = capabilities,
-- 		single_file_support = true,
-- 		handlers = handlers,
-- 		on_attach = on_attach,
-- 	})
-- end
--
-- if vim.fn.executable("rust-analyzer") == 1 then
-- 	lspconfig.rust_analyzer.setup({
-- 		capabilities = capabilities,
-- 	})
-- end
--
if vim.fn.executable("templ") == 1 then
	lspconfig.templ.setup({
		capabilities = capabilities,
	})
end

if vim.fn.executable("gopls") == 1 then
	lspconfig.gopls.setup({
		on_attach = on_attach,
		-- cmd = { "gopls", "-remote=auto" },
		-- cmd = { "gopls", "-remote=auto" },
		-- cmd = { "nix", "run", "nixpkgs#gopls", "--", "--remote=auto" },
		-- cmd = { "nix", "run", "github:NixOS/nixpkgs/24.05#gopls", "--", "--remote=auto" },
		-- capabilities = capabilities,
		settings = {
			gopls = {
				hints = {
					rangeVariableTypes = true,
					parameterNames = true,
					constantValues = true,
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					functionTypeParameters = true,
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
