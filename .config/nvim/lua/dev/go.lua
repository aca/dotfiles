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

vim.cmd.packadd("go-patch-unusedvar.nvim")
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	pattern = "*.go",
	callback = function()
		-- print("write")
		if vim.bo.modifiable then
			pcall(function() require("go-patch-unusedvar")() end)
			-- vim.cmd("silent! write")
			-- print("write")
			-- vim.cmd("write")
		end
	end,
})

-- vim.api.nvim_create_autocmd({ "FocusLost" }, {
-- 	pattern = { "*.go" },
-- 	callback = function()
-- 		vim.cmd.packadd("go-patch-unusedvar.nvim")
-- 		require("go-patch-unusedvar")()
-- 	end,
-- })
