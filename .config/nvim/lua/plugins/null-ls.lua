vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("none-ls.nvim")
vim.cmd.packadd("go-patch-unusedvar.nvim")

local null_ls = require("null-ls")

-- null_ls.setup({
-- 	sources = { null_ls.builtins.code_actions.impl },
-- })
--
null_ls.setup({
})

-- go, implement method action
-- p.parseStatement undefined (type *Parser has no field or method parseStatement)

null_ls.register({
	name = "go-patch-unusedvar",
	method = { require("null-ls").methods.CODE_ACTION },
	filetypes = { "go" },
	generator = {
		fn = function()
			local found = false
			for _, v in ipairs(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) do
				if v["code"] == "UnusedVar" then
					found = true
				end
			end

			if not found then
				return nil
			end

			return {
				{
					title = "patch unused vars",
					action = function()
						require("go-patch-unusedvar")()
					end,
				},
			}
		end,
	},
})

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

require("null-ls").register({
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
					title = "implement method",
					action = function()
                        local pattern = "type ([%w*]+) has no field or method (%w+)"
                        local structname, methodname = message:match(pattern)
                        -- print("func (" .. structname .. ") " .. methodname)
						vim.api.nvim_buf_set_lines(0, -1, -1, false, {
                            "func (*" .. structname .. ") " ..  methodname .. "() {}"
                        })
					end,
				},
			}
		end,
	},
})
