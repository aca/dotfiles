local vim = vim

local ok = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

-- vim.cmd.packadd "gopher.nvim"
--
-- require("gopher").setup {
--   commands = {
--     go = "go",
--     gomodifytags = "gomodifytags",
--     gotests = "gotests",
--     impl = "impl",
--     iferr = "iferr",
--     dlv = "dlv",
--   },
--   -- gotests = {
--   --   -- gotests doesn't have template named "default" so this plugin uses "default" to set the default template
--   --   template = "default",
--   --   -- path to a directory containing custom test code templates
--   --   template_dir = nil,
--   --   -- switch table tests from using slice to map (with test name for the key)
--   --   -- works only with gotests installed from develop branch
--   --   named = false,
--   -- },
--   gotag = {
--     transform = "camelcase",
--   },
-- }
--
local function get_indent(lnum, add)
	-- local lnum = vim.fn.prevnonblank(line)
	-- if lnum < 1 then
	-- 	return ""
	-- end
	local line = vim.fn.getline(lnum + 1) -- ts/lsp line +1 = vim line
	-- print("get_indent: line", line)
	local indent = line:match("^%s*") or ""
	-- print(string.format("indent %q %q", indent, line))
	if add ~= nil then
		return indent + add
	else
		return indent
	end
end

-- vim.cmd.packadd("go.nvim")
-- require("go").setup({
-- 	lsp_inlay_hints = {
-- 		enable = false,
-- 	},
-- 	-- luasnip = true,
-- 	diagnostic = false,
-- 	-- lsp_cfg = {
-- 	--     capabilities = capabilities,
-- 	-- }
-- })

-- vim.cmd.packadd "nvim-go"
-- require('go').setup({
--     -- notify: use nvim-notify
--     notify = false,
--     -- auto commands
--     auto_format = false,
--     auto_lint = false,
--     -- linters: revive, errcheck, staticcheck, golangci-lint
--     linter = 'revive',
--     -- linter_flags: e.g., {revive = {'-config', '/path/to/config.yml'}}
--     linter_flags = {},
--     -- lint_prompt_style: qf (quickfix), vt (virtual text)
--     lint_prompt_style = 'qf',
--     -- formatter: goimports, gofmt, gofumpt, lsp
--     formatter = 'goimports',
--     -- maintain cursor position after formatting loaded buffer
--     maintain_cursor_pos = false,
--     -- test flags: -count=1 will disable cache
--     test_flags = {'-v'},
--     tag_transform = "camelcase",
--     test_timeout = '30s',
--     test_env = {},
--     -- show test result with popup window
--     test_popup = true,
--     test_popup_auto_leave = false,
--     test_popup_width = 80,
--     test_popup_height = 10,
--     -- test open
--     test_open_cmd = 'edit',
--     -- struct tags
--     tags_name = 'json',
--     tags_options = {'json=omitempty'},
--     tags_flags = {'-skip-unexported'},
--     -- quick type
--     quick_type_flags = {'--just-types'},
-- })

-- vim.cmd([[ runtime after/ftplugin/go.lua ]])

-- -- local config = require('go.config')
-- -- local output = require('go.output')
-- -- local util = require('go.util')

-- vim.cmd.packadd("go-patch-unusedvar.nvim")
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
-- 	pattern = "*.go",
-- 	callback = function()
-- 		-- print("write")
-- 		if vim.bo.modifiable then
-- 			-- pcall(function() require("go-patch-unusedvar")() end)
-- 			pcall(function()
-- 				patch()
-- 			end)
-- 			-- vim.cmd("silent! write")
-- 			-- print("write")
-- 			-- vim.cmd("write")
-- 		end
-- 	end,
-- })

-- lua/err_return.lua
local ts_utils = require("nvim-treesitter.ts_utils")
-- _G.ts_utils = ts_utils

-- zero‑value 결정 함수 ──
-- 입력: Treesitter가 뽑은 '타입 문자열'(whitespace 포함 가능)
-- 출력: 그 타입에 맞는 Go 코드 조각
local function zero_value_for(t)
	-- -- 앞뒤 공백 제거
	t = (t:gsub("^%s+", ""):gsub("%s+$", ""))
	--
	-- ▼ ① 내장 기본형
	if t == "bool" then
		return "false"
	elseif t == "string" then
		return '""'
	elseif t == "error" then
		return "nil" -- 실제 호출부에선 마지막에 err 를 붙일 것
	elseif t:match("^u?int") or t:match("^byte$") or t:match("^rune$") then
		return "0"
	elseif t:match("^float") or t == "complex64" or t == "complex128" then
		return "0"
	end

	--
	-- ▼ ② 포인터, 슬라이스, 맵, 채널, 함수타입, 인터페이스
	--    → 전부 nil
	if
		t:match("^%*") -- *T
		or t:match("^%[ %]") -- []T
		or t:match("^map%[") -- map[K]V
		or t:match("^chan%s") -- chan T / <-chan T / chan<- T
		or t:match("^func%(") -- func(...)
		or t == "interface{}" -- 빈 인터페이스 포함
	then
		return "nil"
	end

	-- ▼ ③ 고정 길이 배열 → T{} 와 syntax 충돌을 피하려고 'var <tmp> [N]T; <tmp>' 식도 가능
	--    하지만 단순 반환값이라면 리터럴이 가장 읽기 쉽다.
	local arr_len, _ = t:match("^%[([%d]+)%]%s*(.+)$")
	if arr_len then
		return string.format("%s{}", t)
	end

	-- ▼ ④ struct 타입(이름 있든 없든) → T{}  (컴파일러가 zero init)
	if t:match("^struct%s*{") or t:match("[%w_]+$") then
		return string.format("%s{}", t)
	end

	-- -- ▼ ⑤ 마지막 안전책: 모르는 타입은 nil (대부분 포인터·슬라이스·맵일 확률이 큼)
	return "nil"
end

local function insert_err_return(diag, changed_lines)
	local lnum = diag.lnum + changed_lines
	local col = diag.col
	-- 1) 현재 함수 노드 찾기
	-- local node  = ts_utils.get_root_for_position(d.lnum, d.col)
	-- local node = nil
	local node_diag = vim.treesitter.get_node({ pos = { lnum, col } })
	local node = node_diag

	local node_declare = node_diag:parent():parent()
	if node_declare == nil then
		print("failed to find right block")
		return 0
	end

	local node_declare_start_line = node_declare:start()
	local node_declare_end_line = node_declare:end_()

	-- local node = ts_utils.get_node_at_cursor()
	-- local node  = vim.treesitter.get_node({pos={d.lnum, d.col}})
	-- print(node)

	while
		node
		and (
			node:type() ~= "function_declaration"
			and node:type() ~= "func_literal"
			and node:type() ~= "method_declaration"
		)
	do
		-- print(node:type())
		node = node:parent()
	end
	if not node then
		-- vim.notify('함수 안이 아닙니다', vim.log.levels.WARN)
		return
	end

	-- 2) 결과(리턴 타입) 노드
	local result = node:field("result")[1]
	if not result then
		-- vim.notify('리턴 값이 없는 함수입니다', vim.log.levels.INFO)
		return
	end

	-- vim.print(result:type(), vim.treesitter.get_node_text(result, 0))

	local zero_vals, has_error = {}, false
	local function handle_type(tnode)
		local tname = vim.treesitter.get_node_text(tnode, 0)
		-- vim.print("tname", tname)
		if tname == "error" then
			table.insert(zero_vals, "nil")
			has_error = true
		else
			table.insert(zero_vals, zero_value_for(tname))
		end
	end

	if result:type() == "parameter_list" then
		for tnode in result:iter_children() do
			-- vim.print("---")
			-- vim.print("tnode", tnode:type(), vim.treesitter.get_node_text(tnode, 0))
			-- vim.print("---")
			if tnode:type():match("parameter_declaration") then
				handle_type(tnode)
			end
		end
	else
		handle_type(result)
	end

	if not has_error then
		vim.notify("error 를 리턴하지 않는 함수입니다", vim.log.levels.INFO)
		return
	end

	local ret = table.concat(zero_vals, ", ")
	-- if #ret > 0 then
	-- 	ret = ret .. ", "
	-- end
	-- ret = ret .. "err"

	-- vim.notify('ok get error', vim.log.levels.INFO)
	-- local line = string.format("if err != nil { return %s }", ret)

	local indent = get_indent(node_declare_start_line)
	local lines = { indent .. "if err != nil {", indent .. string.format("\treturn %s", ret), indent .. "}" }
	-- print("err handler insert at ", node_declare_start_line + 1)

	vim.api.nvim_buf_set_lines(0, node_declare_end_line + 1, node_declare_end_line + 1, false, lines)

	-- error handler adds 2 line
	return 2

	--    print("end_row", end_row)
	-- vim.api.nvim_buf_set_lines(0, end_row + 1, end_row + 1, false, lines)

	--
	-- vim.api.nvim_buf_set_lines(0, end_row + 1, end_row + 1, false, { get_indent(start_line) .. line })
	-- -- vim.api.nvim_buf_set_lines(0, end_row -1, end_row -1, false, { "// this should be here" })
	--
	-- --
	-- -- -- 3) 현재 라인 바로 아래에 삽입 (Neovim은 0‑index, vim.fn.line()은 1‑index)
	-- -- local row = vim.fn.line(".")
	-- -- vim.api.nvim_buf_set_lines(0, row, row, false, { line })
end

local function patch_missing_return(diag, changed_lines)
	local lnum = diag.lnum + changed_lines
	local col = diag.col
	-- print("search for root", node, lnum, col)
	local node = vim.treesitter.get_node({ pos = { lnum, col } })
	while
		node
		and (
			node:type() ~= "function_declaration"
			and node:type() ~= "func_literal"
			and node:type() ~= "method_declaration"
		)
	do
		node = node:parent()
	end
	if not node then
		print("not in function")
		-- not inside function
		return 0
	end

	-- 2) 결과(리턴 타입) 노드
	local result = node:field("result")[1]
	if not result then
		-- has no return
		return 0
	end

	local zero_vals, has_error = {}, false
	local function handle_type(tnode)
		local tname = vim.treesitter.get_node_text(tnode, 0)
		-- vim.print("tname", tname)
		table.insert(zero_vals, zero_value_for(tname))
	end

	local namedreturn = false

	if result:type() == "parameter_list" then
		for tnode in result:iter_children() do
			local resultnamefield = tnode:field("name")
			if resultnamefield and #resultnamefield > 0 then
				namedreturn = true
				break
			end

			if tnode:type():match("parameter_declaration") then
				handle_type(tnode)
			end
		end
	else
		local resultnamefield = result:field("name")
		if resultnamefield and #resultnamefield > 0 then
			namedreturn = true
		else
			handle_type(result)
		end
	end

	local ret = ""
	if not namedreturn then
		ret = table.concat(zero_vals, ", ")
	end
	local line = get_indent(lnum) .. "\t" .. string.format("return %s", ret)
	vim.api.nvim_buf_set_lines(0, lnum, lnum, false, { line })
	return 1
end

local function patch_unused_var(diag, changed_lines)
	local lnum = diag.lnum + changed_lines
	local col = diag.col
	local cur_node = vim.treesitter.get_node({ pos = { lnum, col } })
	if cur_node == nil then
		return 0
	end

	local var_name = vim.treesitter.get_node_text(cur_node, 0, {})
	if var_name == "" then
		return 0
	end

	-- print(cur_node:type(), cur_node:parent():type(), cur_node:parent():parent():type())

	local block = cur_node:parent():parent()
	if block == nil then
		return 0
	end

	-- patch `for i := range 3 {}`
	if block:type() == "range_clause" then
		local start_line, _ = block:parent():start()
		local end_row = block:end_()
		vim.api.nvim_buf_set_lines(
			0,
			start_line + 1,
			start_line + 1,
			false,
			{ get_indent(start_line) .. "\t_ = " .. var_name }
		)
		return 1

	-- var x = 3
	-- var f = func() int {
	-- }
	-- _ = f
	elseif block:type() == "var_declaration" then
		local start_line = block:start()
		local end_row = block:end_()
		vim.api.nvim_buf_set_lines(0, end_row + 1, end_row + 1, false, { get_indent(start_line) .. "_ = " .. var_name })
		return 1

	-- x := 3
	-- f := func() int {}
	-- _ = f
	elseif block:type() == "short_var_declaration" then
		-- vim.api.nvim_buf_set_lines(
		-- 	0,
		--           lnum + 1,
		--           lnum + 1,
		-- 	false,
		-- 	{ get_indent(lnum) .. "_ = " .. var_name }
		-- )

		local start_line = block:start()
		local end_row = block:end_()
		vim.api.nvim_buf_set_lines(0, end_row + 1, end_row + 1, false, { get_indent(lnum) .. "_ = " .. var_name })
		return 1
		-- if var_name == "err" then
		-- 	vim.api.nvim_buf_set_lines(0, end_row + 1, end_row + 1, false, { indent .. "if err != nil {" })
		-- else
		-- 	vim.api.nvim_buf_set_lines(0, end_row + 1, end_row + 1, false, { indent .. "_ = " .. var_name })
		-- end
	end
end

local function patch_undefined_ctx(diag, changed_lines)
	local lnum = diag.lnum + changed_lines
	local col = diag.col
	-- local cur_node = vim.treesitter.get_node({ pos = { lnum, col } })
	-- if cur_node == nil then
	-- 	return 0
	-- end
	--
    vim.api.nvim_buf_set_lines(0, lnum, lnum, false, { get_indent(lnum) .. "ctx := context.Background()"  })
    return 1
end

local patch = function()
	-- print("patch")
	local changed_lines = 0
	local diags = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	if not diags and #diags == 0 then
		return
	end

	-- for _, diag in ipairs(diags) do
	-- 	print(diag.lnum, diag.col, diag.code, diag.message)
	-- end

	for _, diag in ipairs(diags) do
		-- lsp: line 5 -> vim 6
		-- vim.print(diag)
		-- print(string.format("diag: lnum %q, code: %q, changed_lines: %q", diag.lnum, diag.code, changed_lines))
		if diag["code"] == "MissingReturn" then
			local changed = patch_missing_return(diag, changed_lines)
			changed_lines = changed_lines + changed
            return
		elseif diag["code"] == "UnusedVar" then
			if diag["message"] == "declared and not used: err" then
				local changed = insert_err_return(diag, changed_lines)
				-- local changed = patch_unused_var(diag, changed_lines)
				changed_lines = changed_lines + changed
                return
			else
				local changed = patch_unused_var(diag, changed_lines)
				changed_lines = changed_lines + changed
                return
			end
		elseif diag["message"] == "undefined: ctx" then
				local changed = patch_undefined_ctx(diag, changed_lines)
				changed_lines = changed_lines + changed
		end
	end
end

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	pattern = { "*.go" },
	callback = function()
		if vim.bo.modifiable then
			pcall(function()
				patch()
			end)
		end
	end,
})


-- 4) 키 매핑
-- vim.keymap.set("n", "<leader>er", insert_err_return, { desc = "자동 err 리턴 삽입", silent = true })
