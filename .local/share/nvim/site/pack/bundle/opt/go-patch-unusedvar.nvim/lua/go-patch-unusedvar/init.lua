local patch = function()
	local patchtable = {}
	local count = 0
	for _, v in ipairs(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) do
		if v["code"] == "UnusedVar" then
			count = count + 1

			local cur_node = vim.treesitter.get_node({
				bufnr = 0,
				pos = { v.lnum, v.col },
				lang = "go",
			})

			-- vim.print(cur_node)
			-- vim.print(cur_node:type())
			-- vim.print(cur_node:parent():type())
			-- vim.print(cur_node:parent():parent():type())

			if cur_node == nil then
				return 1
			end
			-- TODO: handle error cases
			local var_name = vim.treesitter.get_node_text(cur_node, 0, {})

			-- append line at the end of declaration
			local block = cur_node:parent():parent()
			if block == nil then
				return 1
			end

			if block:type() == "range_clause" then
                print("this is range")
                block = block
				-- local _, start_col = block:start()
				local _, start_col = block:parent():start()
				local end_row = block:end_()
				patchtable[count] = { end_row + 1, string.rep("\t", start_col + 1) .. "_ = " .. var_name }
			else
				local _, start_col = block:start()
				local end_row = block:end_()
				patchtable[count] = { end_row + 1, string.rep("\t", start_col) .. "_ = " .. var_name }
			end
		end
	end

	for k, v in pairs(patchtable) do
		-- Error executing lua callback: .../go-patch-unusedvar.nvim/lua/go-patch-unusedvar/init.lua:32: 'replacement string' item contains newlines
		-- stack traceback:
		--         [C]: in function 'nvim_buf_set_lines'
		--         .../go-patch-unusedvar.nvim/lua/go-patch-unusedvar/init.lua:32: in function <.../go-patch-unusedv
		if not string.find(v[2], "\n") then
			vim.api.nvim_buf_set_lines(0, v[1] + k - 1, v[1] + k - 1, false, { v[2] })
		end
	end
end

vim.api.nvim_create_user_command("GoPatchUnusedVar", function()
	patch()
end, {})

return patch
