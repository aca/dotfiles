require("impatient") -- https://github.com/lewis6991/impatient.nvim

-- DEBUG [[
-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)
-- ]]

-- UPDATE [[
-- :TSInstall all
-- :TSUpdate all
--
-- :LspUpdateAll
-- ]]

-- TODO: jupyter integration
-- https://www.reddit.com/r/neovim/comments/p206ju/magmanvim_interact_with_jupyter_from_neovim/
-- https://github.com/dccsillag/magma-nvim

-- TODO: zettels related
-- require 'zettels'

local vim = vim
local g = vim.g
local cmd = vim.cmd

-- require("impatient").enable_profile() -- DEBUG
require("globals")
require("vim")
require("plugins.filetype")
if not g._minimal then
	require("plugins.lsp")
	require("plugins.treesitter")
end

vim.loop.new_timer():start(
	200,
	0,
	vim.schedule_wrap(function()
		require("plugins.tmux")

		if not g._minimal then
			cmd("packadd plenary.nvim")
			require("plugins.autopairs")
			require("plugins.cmp")
			require("plugins.luasnip")

			require("plugins.dap")
			require("plugins.neoformat")

			require("plugins.buftabline")
			require("plugins.scrollview")
			require("plugins.dadbod")
			require("plugins.zenmode")
			require("plugins.oscyank")

			-- git
			require("plugins.gitlinker")
			require("plugins.octo")
			require("plugins.git-messenger")
			require("plugins.gitsigns")

			-- edit
			require("plugins.comment")
			require("plugins.move")
			require("plugins.lion")
			require("plugins.autopairs")
			require("plugins.dial")
			require("plugins.suda")
			require("plugins.vim-test")

			-- nav
			require("plugins.telescope")
			require("plugins.hop")
		end

		-- lazyload
		-- require("plugins.matchparen") -- TODO: fix
		cmd("runtime! autoload/plugin/*")
		cmd("runtime! autoload/func/*")
		cmd("runtime! autoload/autocmd/*")
		cmd("runtime! autoload/command/*")
		cmd("runtime! autoload/map/*")
		cmd("runtime! autoload/lib/*")
		cmd("runtime! autoload/local/*")
	end)
)
