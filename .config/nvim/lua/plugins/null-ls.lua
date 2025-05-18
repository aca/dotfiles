vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("none-ls.nvim")

-- vim.cmd.packadd("go-patch-unusedvar.nvim")

local null_ls = require("null-ls")

local b = null_ls.builtins

local sources = {
	-- b.formatting.gofumpt,
	-- b.formatting.goimports,
	-- b.diagnostics.golangci_lint,
}

null_ls.setup({
	-- sources = { null_ls.builtins.code_actions.impl },
	debug = false,
	sources = sources,
})

-- local api = vim.api
-- local function get_diagnostic_at_cursor()
-- 	local cur_buf = api.nvim_get_current_buf()
-- 	-- local line, col = unpack(api.nvim_win_get_cursor(0))
-- 	local line, col = 4, 0
-- 	local entrys = vim.diagnostic.get(cur_buf, { lnum = line - 1 })
-- 	local res = {}
-- 	for _, v in pairs(entrys) do
-- 		if v.col <= col and v.end_col >= col then
-- 			table.insert(res, {
-- 				code = v.code,
-- 				message = v.message,
-- 				range = {
-- 					["start"] = {
-- 						character = v.col,
-- 						line = v.lnum,
-- 					},
-- 					["end"] = {
-- 						character = v.end_col,
-- 						line = v.end_lnum,
-- 					},
-- 				},
-- 				severity = v.severity,
-- 				source = v.source or nil,
-- 			})
-- 		end
-- 	end
-- 	return res
-- end

-- vim.lsp.buf.code_action({
--  context = {
--       diagnostics = get_diagnostic_at_cursor()
-- }})

-- null_ls.register({
-- 	name = "go-patch-unusedvar",
-- 	method = { require("null-ls").methods.CODE_ACTION },
-- 	filetypes = { "go" },
-- 	generator = {
-- 		fn = function()
-- 			local found = false
-- 			for _, v in ipairs(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) do
-- 				if v["code"] == "UnusedVar" then
-- 					return {
-- 						{
-- 							title = "patch unused vars",
-- 							action = function()
-- 								require("go-patch-unusedvar")()
-- 							end,
-- 						},
-- 					}
-- 				end
-- 			end
-- 		end,
-- 	},
-- })

local function extract_last_url(msg)
	-- Pattern to match the last URL
	local url = msg:match("([%w%.%-]+/%S+)")
	return url
end

-- local gogetmap = {}
-- null_ls.register({
-- 	name = "go-get",
-- 	method = { require("null-ls").methods.DIAGNOSTICS },
-- 	filetypes = { "go" },
-- 	generator = {
-- 		fn = function()
-- 			local found = false
-- 			for _, v in ipairs(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) do
-- 				-- Function to extract the last URL
-- 				if v["code"] == "BrokenImport" then
-- 					-- vim.print(extract_last_url(v["message"]))
-- 					local url = extract_last_url(v["message"])
-- 					if gogetmap[url] ~= nil then
-- 						return
-- 					end
-- 					gogetmap = {
-- 						url = true,
-- 					}
-- 					vim.fn.jobstart("go get -u " .. url)
-- 					return {}
-- 				end
-- 				if v["code"] == "NoNewVar" then
--                     vim.cmd(':' .. v["lnum"] + 1 .. 's/:=/=/')
--                     -- vim.lsp.buf.code_action({ apply = true, filter = function(action) return action.title == "Organize Imports" end })
--                     -- return nil
-- 				end
-- 			end
-- 			return {}
-- 		end,
-- 	},
-- })

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
