vim.cmd.packadd("conform.nvim")
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { {  "biome", "prettier", "prettierd" } },
		html = { {  "prettier", "prettierd", "biome" } }, -- biome doesn't support html yet
		nix = { { "alejandra", "nixfmt" } },
		jsonc = { { "deno_fmt" } },
		json = { { "deno_fmt" } },
		sql = { { "sql_formatter" } },
	},
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set("n", ";f", function()
	local filetype = vim.bo.filetype
	if filetype == "go" then
		vim.lsp.buf.format({ async = false })
		vim.lsp.buf.code_action({
			apply = true,
			filter = function(action)
				return action.title == "Organize Imports"
			end,
		})
	elseif
		filetype == "typescript"
		or filetype == "javascript"
		or filetype == "javascriptreact"
		or filetype == "typescriptreact"
	then
		vim.lsp.buf.format({ formatting_options = { tabSize = 2 } })
		vim.lsp.buf.execute_command({
			command = "_typescript.organizeImports",
			arguments = { vim.api.nvim_buf_get_name(0) },
		})
	else
		require("conform").format()
	end
	vim.cmd([[ normal! zX ]]) -- update fold
end, { silent = true })

-- auto organize imports
vim.api.nvim_create_autocmd({ "InsertLeave", "CursorHoldI" }, {
	pattern = "*.go",
	callback = function()
		vim.lsp.buf.code_action({
			apply = true,
			filter = function(action)
				return action.title == "Organize Imports"
			end,
		})
	end,
})
