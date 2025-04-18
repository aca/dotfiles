local vim = vim
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

vim.cmd.packadd("go.nvim")
require("go").setup({
	lsp_inlay_hints = {
		enable = false,
	},
	-- luasnip = true,
	diagnostic = false,
	-- lsp_cfg = {
	--     capabilities = capabilities,
	-- }
})

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

vim.cmd([[ runtime after/ftplugin/go.lua ]])

-- -- local config = require('go.config')
-- -- local output = require('go.output')
-- -- local util = require('go.util')
--
-- -- function go_iferr()
-- --     local boff = vim.fn.wordcount().cursor_bytes
-- --     local cmd = ('iferr' .. ' -pos ' .. boff)
-- --     local data = vim.fn.systemlist(cmd, vim.fn.bufnr('%'))
-- --
-- --     if vim.v.shell_error ~= 0 then
-- --         -- output.show_error(
-- --         --     prefix,
-- --         --     'command ' .. cmd .. ' exited with code ' .. vim.v.shell_error
-- --         -- )
-- --         print("error", vim.v.shell_error)
-- --         return
-- --     end
-- --
-- --     local r, c = unpack(vim.api.nvim_win_get_cursor(0))
-- --     -- local pos = vim.fn.getcurpos()[2]
-- --     -- vim.fn.append(pos, data)
-- --     vim.api.nvim_buf_set_lines(0, r-1, r, true, data)
-- --     vim.cmd([[silent normal! kj=2jjjo]])
-- --     -- vim.fn.setpos('.', pos)
-- -- end
-- --
-- -- vim.api.nvim_create_user_command("GoIfErr", function()
-- --     go_iferr()
-- -- end, {})
--


-- vim.api.nvim_create_autocmd({ "FocusLost" }, {
-- 	pattern = { "*.go" },
-- 	callback = function()
-- 		vim.cmd.packadd("go-patch-unusedvar.nvim")
-- 		require("go-patch-unusedvar")()
-- 	end,
-- })
--
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

			-- if var_name == "err" then
			--     patchtable[count] = { v.lnum + 1, string.rep("\t", 1) .. "_ = " .. var_name }
			-- end

			if block:type() == "range_clause" then
				block = block
				-- local _, start_col = block:start()
				local _, start_col = block:parent():start()
				local end_row = block:end_()
				patchtable[count] = { end_row + 1, { string.rep("\t", start_col + 1) .. "_ = " .. var_name } }
			else
				local _, start_col = block:start()
				local end_row = block:end_()

                local indent = string.rep("\t", start_col)
				if var_name == "err" then
					patchtable[count] = { end_row + 1, { indent .. "if err != nil {", indent .. "\t" .. "panic(err)", indent .. "}"}}
				else
                    patchtable[count] = { end_row + 1, { indent .. "_ = " .. var_name } }
				end
                -- patchtable[count] = { end_row + 1, string.rep("\t", start_col) .. "_ = " .. var_name }
			end
		end
	end

	for k, v in pairs(patchtable) do
		-- if not string.find(v[2], "\n") then
        vim.api.nvim_buf_set_lines(0, v[1] + k - 1, v[1] + k - 1, false, v[2])
		-- end
	end
end

vim.cmd.packadd("go-patch-unusedvar.nvim")
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
local ts_utils = require('nvim-treesitter.ts_utils')

-- zero‑value 결정 함수 ──
-- 입력: Treesitter가 뽑은 '타입 문자열'(whitespace 포함 가능)
-- 출력: 그 타입에 맞는 Go 코드 조각
local function zero_value_for(t)
  -- -- 앞뒤 공백 제거
  t = (t:gsub('^%s+', ''):gsub('%s+$', ''))
  --
  -- ▼ ① 내장 기본형
  if     t == 'bool'      then return 'false'
  elseif t == 'string'    then return '""'
  elseif t == 'error'     then return 'err'        -- 실제 호출부에선 마지막에 err 를 붙일 것
  elseif t:match('^u?int')  or
         t:match('^byte$') or t:match('^rune$')  then return '0'
  elseif t:match('^float') or t == 'complex64' or t == 'complex128' then return '0'
  end

  --
  -- ▼ ② 포인터, 슬라이스, 맵, 채널, 함수타입, 인터페이스
  --    → 전부 nil
  if t:match('^%*') or        -- *T
     t:match('^%[ %]') or     -- []T
     t:match('^map%[') or     -- map[K]V
     t:match('^chan%s') or    -- chan T / <-chan T / chan<- T
     t:match('^func%(') or    -- func(...)
     t == 'interface{}'       -- 빈 인터페이스 포함
  then
    return 'nil'
  end
  --
  -- ▼ ③ 고정 길이 배열 → T{} 와 syntax 충돌을 피하려고 'var <tmp> [N]T; <tmp>' 식도 가능
  --    하지만 단순 반환값이라면 리터럴이 가장 읽기 쉽다.
  local arr_len, elem_t = t:match('^%[([%d]+)%]%s*(.+)$')
  if arr_len then
    return string.format('%s{}', t)
  end

  -- ▼ ④ struct 타입(이름 있든 없든) → T{}  (컴파일러가 zero init)
  if t:match('^struct%s*{') or t:match('[%w_]+$') then
    return string.format('%s{}', t)
  end

  -- -- ▼ ⑤ 마지막 안전책: 모르는 타입은 nil (대부분 포인터·슬라이스·맵일 확률이 큼)
  return 'nil'
end


-- 간단한 zero‑value 매핑
-- local function zero_value_for(type_name)
--   if type_name == 'int'       or type_name == 'int32'
--      or type_name == 'int64'  or type_name == 'uint'
--      or type_name == 'float32' or type_name == 'float64' then
--     return '0'
--   elseif type_name == 'string' then
--     return '""'
--   elseif type_name == 'bool' then
--     return 'false'
--   else
--     -- 포인터, slice, map, chan 등은 nil 로 처리
--     return 'nil'
--   end
-- end

local function insert_err_return()
  -- 1) 현재 함수 노드 찾기
  local node = ts_utils.get_node_at_cursor()
  while node and node:type() ~= 'function_declaration' do
    node = node:parent()
  end
  if not node then
    vim.notify('함수 안이 아닙니다', vim.log.levels.WARN)
    return
  end

  -- 2) 결과(리턴 타입) 노드
  local result = node:field('result')[1]
  if not result then
    vim.notify('리턴 값이 없는 함수입니다', vim.log.levels.INFO)
    return
  end

  -- vim.print("result start")
  -- vim.print(result:type(), vim.treesitter.get_node_text(result, 0))
  -- vim.print("result end")

  local zero_vals, has_error = {}, false
  local function handle_type(tnode)
    local tname = vim.treesitter.get_node_text(tnode, 0)
    -- vim.print("tname", tname)
    if tname == 'error' then
      has_error = true
    else
      table.insert(zero_vals, zero_value_for(tname))
    end
  end

  -- vim.print("zero_vals", zero_vals)

  if result:type() == 'parameter_list' then
    for tnode in result:iter_children() do
      -- vim.print("---")
      -- vim.print("tnode", tnode:type(), vim.treesitter.get_node_text(tnode, 0))
      -- vim.print("---")
      if tnode:type():match('parameter_declaration') then
        handle_type(tnode)
      end
    end
  else
    handle_type(result)
  end

  if not has_error then
    vim.notify('error 를 리턴하지 않는 함수입니다', vim.log.levels.INFO)
    return
  end

  local ret = table.concat(zero_vals, ', ')
  if #ret > 0 then ret = ret .. ', ' end
  ret = ret .. 'err'

  local line = string.format('if err != nil { return %s }', ret)

  -- 3) 현재 라인 바로 아래에 삽입 (Neovim은 0‑index, vim.fn.line()은 1‑index)
  local row = vim.fn.line('.')
  vim.api.nvim_buf_set_lines(0, row, row, false, { line })
end

-- 4) 키 매핑
vim.keymap.set('n', '<leader>er', insert_err_return,
  { desc = '자동 err 리턴 삽입', silent = true })
