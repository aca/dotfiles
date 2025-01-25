vim.cmd.packadd("conform.nvim")
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "biome", "prettier", "prettierd" } },
		typescript = { { "biome", "prettier", "prettierd" } },
		javascriptreact = { { "biome", "prettier", "prettierd" } },
		typescriptreact = { { "biome", "prettier", "prettierd" } },
		html = { { "prettier", "prettierd", "biome" } }, -- biome doesn't support html yet
		nix = { { "alejandra", "nixfmt" } },
		jsonc = { { "deno_fmt" } },
		json = { { "deno_fmt" } },
		sql = { { "sql_formatter" } },
		zig = { { "zigfmt" } },
	},
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- vim.lsp.set_log_level(vim.lsp.log.levels.OFF) doesn't work
function silent_notify(msg, level, opts) -- luacheck: no unused args
	if level == vim.log.levels.ERROR or level == vim.log.levels.WARN then
		vim.api.nvim_err_writeln(msg)
	end
end

vim.keymap.set("n", ";f", function()
	local filetype = vim.bo.filetype
	if filetype == "go" then
		-- local prev = vim.lsp.log.get_level()
		-- local notify = vim.notify
		-- vim.notify = silent_notify
		vim.lsp.buf.format({ async = false })
		vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
		-- vim.defer_fn(function()
		--     vim.notify = notify
		-- end, 50)
	elseif
		filetype == "typescript"
		or filetype == "javascript"
		or filetype == "javascriptreact"
		or filetype == "typescriptreact"
	then
     	-- require("conform").format()
     	-- return
		local clients = vim.lsp.get_clients({ name = "vtsls" })
		if clients == nil then
			require("conform").format()
			return
		end
		local client = clients[1]
		-- client.request("workspace/executeCommand", {
		-- 	command = "typescript.organizeImports",
		-- 	arguments = { vim.api.nvim_buf_get_name(0) },
		-- })
		-- client.request("workspace/executeCommand", {
		-- 	command = "typescript.sortImports",
		-- 	arguments = { vim.api.nvim_buf_get_name(0) },
		-- })
		vim.lsp.buf.format({
			formatting_options = { tabSize = 2 },
			vim.lsp.buf.format({
				filter = function(_client)
					return _client.name == "vtsls"
				end,
			}),
		})
	else
		require("conform").format()
	end
	-- vim.cmd([[ normal! zX ]]) -- update fold
end, { silent = true })

-- automatic import
-- vim.api.nvim_create_autocmd({ "InsertLeave", "CursorHoldI" }, {
-- 	pattern = "*.go",
-- 	callback = function()
-- 		-- require("conform").format()
--         -- vim.lsp.buf.format(nil)
--
-- 		-- vim.lsp.buf.code_action({
-- 		-- 	apply = true,
-- 		-- 	filter = function(action)
-- 		-- 		return action.title == "Organize Imports"
-- 		-- 	end,
-- 		-- })
--         -- vim.lsp.buf.code_action({ source = { organizeImports = true  }, apply= true })
--
--         vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
-- 	end,
-- })
