local null_ls = require("null-ls")
local api = vim.api
local Job = require("plenary.job")
local curl = require("plenary.curl")

local no_really = {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { "markdown", "txt" },
	generator = {
		fn = function(params)
			local diagnostics = {}
			-- sources have access to a params object
			-- containing info about the current file and editor state
			for i, line in ipairs(params.content) do
				-- local col, end_col = line:find("really")
				local col, end_col = line:find("[http://][https://][%w|%p]*")

				if col and end_col then
					local url = string.sub(line, col, end_col)

					-- print(url)
					-- local rees = curl.get(url)
					-- print(P(res))
					--
					local res = curl.post("https://postman-echo.com/post", {
						body = "Hello World!",
					})
					print(vim.inspect.inspect(res))

					-- local cmd = 'curl -s --fail "' .. url .. '"' .. '|' .. "gsed -n 's/.*<title>\\(.*\\)<\\/title>.*/\\1/ip;T;q'"
					-- local title = vim.fn.systemlist(cmd)[1]
					-- print(title)
					-- local err = vim.api.nvim_get_vvar("shell_error")
					-- if 0 ~= err then
					--   continue
					-- end

					-- local title = vim.fn.systemlist(cmd)[1]

					-- null-ls fills in undefined positions
					-- and converts source diagnostics into the required format
					table.insert(diagnostics, {
						row = i,
						col = col,
						end_col = end_col,
						source = "zettels",
						-- message = "Don't use 'really!'",
						message = title,
						-- message = url,
						severity = 4,
					})
				end
			end
			return diagnostics
		end,
	},
}

-- null_ls.register(no_really)
-- null_ls.config({})
-- require("lspconfig")["null-ls"].setup({})
