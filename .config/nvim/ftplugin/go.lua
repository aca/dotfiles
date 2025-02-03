local vim = vim
vim.o.expandtab = false

local runTmux = function(cmd)
	local pane_id = vim.fn.system('tmux split-window -d -P -F "#{pane_id}"')
	pane_id = vim.trim(pane_id)
	vim.fn.system({ "tmux", "send-keys", "-t", pane_id, "clear", "Enter", cmd, "Enter" })
end

local tmux_split_and_go_run = function()
	local pane_id = vim.fn.system('tmux split-window -d -P -F "#{pane_id}"')
	pane_id = vim.trim(pane_id)
	local bufname = vim.api.nvim_buf_get_name(0)
	vim.fn.system({ "tmux", "send-keys", "-t", pane_id, "clear", "Enter", "go run " .. bufname, "Enter" })
end

vim.keymap.set("n", "<leader>rr", tmux_split_and_go_run, { noremap = true, silent = true })

local gotest = function()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local get_node_text = vim.treesitter.get_node_text

	local function get_function_name_at_cursor()
		local node = ts_utils.get_node_at_cursor()
		if not node then
			return nil
		end

		while node do
			local node_type = node:type()
			if node_type == "function_declaration" then
				print("matched")
				local name_node = node:child(1)
				print("name_node", name_node)
				if name_node and name_node:type() == "identifier" then
					name = get_node_text(name_node, 0)
					return name
				else
					return nil
				end
			end

			print("go to aprent", node:type())
			node = node:parent()
		end

		return nil
	end
	runTmux("go test -v -run " .. "'^" .. get_function_name_at_cursor() .. "$'")
end

vim.keymap.set("n", "<leader>rt", gotest, { noremap = true, silent = false })
