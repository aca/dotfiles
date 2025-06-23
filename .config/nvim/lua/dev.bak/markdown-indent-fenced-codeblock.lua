-- debug
-- vim.cmd.packadd('nvim-notify')
-- vim.notify = require("notify")

local ns_id = vim.api.nvim_create_namespace("demo")
local indentString = "    "

local function indent_line(line_num)
	local col_num = 0
	local opts = {
		-- end_line = line_num + 1,
		-- id = line_num,
		virt_text = { { indentString, "Normal" } },
		virt_text_pos = "inline",
		invalidate = true,
		undo_restore = false,
	}
	local mark = vim.api.nvim_buf_get_extmarks(0, ns_id, { line_num, 0 }, { line_num, 0 }, {})

	-- indent only if extmark not exists on current line
	if next(mark) == nil then
		-- vim.api.nvim_buf_set_extmark(0, ns_id, line_num, col_num, opts)
        vim.api.nvim_buf_set_extmark(
            0,
            ns_id,
            line_num, 0,
            { line_hl_group = 'DiffDelete' }
        )
	end
end

local function hide_language(line_num)
	local col_num = 0
	local opts = {
		-- end_line = line_num + 1,
		-- id = line_num,
		-- virt_text = { { indentString, "Normal" } },
		-- virt_text_pos = "inline",
		-- invalidate = true,
		-- undo_restore = false,
		--
		end_row = line_num + 1,
		end_col = 0,
		-- hl_group = background,
		virt_text = { { "                                 ", "Normal"} },
		virt_text_pos = "overlay",
		hl_eol = true,
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
			-- hide language
			-- hide_language(range[1] - 1)
			for i = range[1], range[3] - 1, 1 do
				indent_line(i)
			end
			-- hide_language(range[3])
		end
	end
end
-- local function indent_clear_all()
-- simply, remove namespace, clear all mark
-- vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
-- ns_id = vim.api.nvim_create_namespace('demo')
-- end

local function indent_clear(node)
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

local function update(mode)
	-- delete all marks in the block
	local node = vim.treesitter.get_node()
	if node == nil then
		-- vim.notify("node == nil, skip")
		return
	end

	local nodetype = node:type()
	-- vim.notify("nodetype: " .. nodetype)
	if
		nodetype == "code_fence_content"
		or nodetype == "fenced_code_block"
		or nodetype == "fenced_code_block_delimiter"
	then
		-- clear indentation in current node
		if mode == "I" then
			indent_clear(node)
		end
	else
		-- reindent
		indent_codeblock()
	end
end

-- local augroup = vim.api.nvim_create_augroup("markdown-indent-fenced-codeblock", { clear = true })
-- vim.api.nvim_create_autocmd({ "TextChanged" }, {
-- 	pattern = { "*.md" },
-- 	callback = function()
-- 		update("I")
-- 	end,
-- 	group = augroup,
-- })
-- vim.api.nvim_create_autocmd({ "CursorMoved" }, {
-- 	pattern = { "*.md" },
-- 	callback = function()
-- 		update("")
-- 	end,
-- 	group = augroup,
-- })
-- vim.api.nvim_create_autocmd({ "BufLeave", "InsertLeave" }, {
-- 	pattern = { "*.md" },
-- 	callback = indent_codeblock,
-- 	group = augroup,
-- })
-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
-- 	pattern = { "*.md" },
-- 	callback = function()
-- 		update("I")
-- 	end,
-- 	group = augroup,
-- })

-- indent_codeblock()
