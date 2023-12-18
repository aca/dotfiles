-- debug
-- vim.cmd.packadd('nvim-notify')
-- vim.notify = require("notify")

local ns_id = vim.api.nvim_create_namespace("demo")

local function indent_line(line_num)
	local col_num = 0
	local opts = {
		-- end_line = line_num + 1,
		-- id = line_num,
		virt_text = { { "    ", "Normal" } },
		virt_text_pos = "inline",
		invalidate = true,
		undo_restore = false,
	}
	local mark = vim.api.nvim_buf_get_extmarks(0, ns_id, { line_num, 0 }, { line_num, 0 }, {})

	-- indent only if extmark not exists on current line
	if next(mark) == nil then
		vim.api.nvim_buf_set_extmark(0, ns_id, line_num, col_num, opts)
	end
end

local function indent_codeblock()
	local language_tree = vim.treesitter.get_parser(vim.fn.bufnr("%"))
	if language_tree == nil then
		return
	end

	local syntax_tree = language_tree:parse()
	local root = syntax_tree[1]:root()
	local query = vim.treesitter.query.parse(
		"markdown",
		[[
    ((code_fence_content) @code (#offset! @code))
    ]]
	)

	---@diagnostic disable-next-line: missing-parameter
	for _, _, metadata in query:iter_matches(root) do
		local range = metadata[1].range
		if range[3] - range[1] > 0 then
			for i = range[1], range[3] - 1, 1 do
				indent_line(i)
			end
		end
	end
end

local function indent_clear(node)
	-- simply, remove namespace?
	-- 	vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
	-- 	ns_id = vim.api.nvim_create_namespace('demo')

	local r1, _, r3, _ = vim.treesitter.get_node_range(node)
	local block = vim.api.nvim_buf_get_extmarks(0, ns_id, { r1, 0 }, { r3, 0 }, {})
	for _, name in ipairs(block) do
		vim.api.nvim_buf_del_extmark(0, ns_id, name[1])
	end

	-- fix duplicate mark
	local tmp = {}
	local allmarks = vim.api.nvim_buf_get_extmarks(0, ns_id, { 0, 0 }, { -1, -1 }, {})
	for i = 1, #allmarks do
		local e = allmarks[i]
		if tmp[e[2]] == nil then
			tmp[e[2]] = e[2]
		else
			-- vim.notify("delete" .. e[2] .."/" .. e[1])
			vim.api.nvim_buf_del_extmark(0, ns_id, e[1])
		end
	end
end

local function update()
	-- delete all marks in the block
	local node = vim.treesitter.get_node()
	if node == nil then
		-- vim.notify("skip" .. node:type())
		return
	end

	local nodetype = node:type()
	if
		nodetype == "code_fence_content"
		or nodetype == "fenced_code_block"
		or nodetype == "fenced_code_block_delimiter"
	then
		indent_codeblock()
	else
		indent_clear(node)
	end
end

vim.api.nvim_create_autocmd({ "CursorMoved" }, {
	pattern = { "*.md" },
	callback = function()
		update()
	end,
})

-- indent_codeblock()
