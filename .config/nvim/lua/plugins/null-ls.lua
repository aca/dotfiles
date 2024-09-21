vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("none-ls.nvim")

vim.cmd.packadd("go-patch-unusedvar.nvim")

local null_ls = require("null-ls")
null_ls.setup({
	-- sources = { null_ls.builtins.code_actions.impl },
	debug = false,
})

null_ls.register({
	name = "go-patch-unusedvar",
	method = { require("null-ls").methods.CODE_ACTION },
	filetypes = { "go" },
	generator = {
		fn = function()
			local found = false
			for _, v in ipairs(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) do
				if v["code"] == "UnusedVar" then
					return {
						{
							title = "patch unused vars",
							action = function()
								require("go-patch-unusedvar")()
							end,
						},
					}
				end
			end
		end,
	},
})

null_ls.register({
	name = "goimports",
	method = { require("null-ls").methods.DIAGNOSTICS },
	filetypes = { "go" },
	generator = {
		fn = function()
			for _, v in ipairs(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) do
				-- if v["code"] == "UndeclaredName" or v["code"] == "UnusedImport" then
				--                 print(running_go_imports)
				-- 	if not running_go_imports then
				-- 		running_go_imports = true
				--
				-- 		vim.lsp.buf.code_action({
				-- 			apply = true,
				-- 			filter = function(action)
				-- 				return action.title == "Organize Imports"
				-- 			end,
				-- 		})
				--
				-- 	vim.defer_fn(function()
				-- 		running_go_imports = false
				-- 	end, 200)
				-- 	return {}
				-- end

				if v["code"] == "BrokenImport" then
                    vim.print(v)

					-- local params = vim.lsp.util.make_range_params(nil, nil)
					-- local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
					-- for _, res in pairs(result or {}) do
					-- 	for _, r in pairs(res.result or {}) do
     --                        vim.print(r)
					-- 		-- if r.kind == "source.organizeImports" then
					-- 		-- 	vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
					-- 		-- 	-- running_go_imports = false
					-- 		-- 	return
					-- 		-- end
					-- 	end
					-- end

					-- vim.lsp.buf.code_action({
					-- 	only = { "quickfix" },
					-- 	apply = true,
					-- 	filter = function(action)
					--                        if string.find(actions.command, "get") then
					--                            return true
					--                        else
					--                            return false
					--                        end
					-- 	end,
					-- })
					-- vim.lsp.buf.code_action({
					-- 	apply = true,
					-- })
					return {}
				end
			end
			return {}
		end,
	},
})

-- go, implement method action
-- p.parseStatement undefined (type *Parser has no field or method parseStatement)
require("null-ls").register({
	-- { {
	--     bufnr = 4,
	--     code = "MissingFieldOrMethod",
	--     col = 5,
	--     end_col = 8,
	--     end_lnum = 7,
	--     lnum = 7,
	--     message = "xxx.rer undefined (type x has no field or method rer)",
	--     namespace = 28,
	--     severity = 1,
	--     source = "compiler",
	--     user_data = {
	--       lsp = {
	--         code = "MissingFieldOrMethod",
	--         codeDescription = {
	--           href = "https://pkg.go.dev/golang.org/x/tools/internal/typesinternal#
	-- MissingFieldOrMethod"
	--         }
	--       }
	--     }
	--   } }

	name = "go-method-impl",
	method = { require("null-ls").methods.CODE_ACTION },
	filetypes = { "go" },
	generator = {
		fn = function()
			-- TODO: handle multple

			local found = false
			local message = ""
			for _, v in ipairs(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) do
				if v.code and v.code == "MissingFieldOrMethod" then
					found = true
					message = v.message
				end
			end

			if not found then
				return nil
			end

			return {
				{
					title = "Implement method",
					action = function()
						local pattern = "type ([%w*]+) has no field or method (%w+)"
						local structname, methodname = message:match(pattern)
						-- print("func (" .. structname .. ") " .. methodname)
						vim.api.nvim_buf_set_lines(0, -1, -1, false, {
							"func (*" .. structname .. ") " .. methodname .. "() {}",
						})
					end,
				},
			}
		end,
	},
})
