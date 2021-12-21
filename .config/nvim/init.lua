-- OPT [[
-- vim.lsp.set_log_level("debug")
-- require('vim.lsp.log').set_format_func(vim.inspect)
-- ]]

-- UPDATE [[
-- :TSInstall all
-- :TSUpdate all
-- ]]

-- TODO: jupyter integration [[
-- https://www.reddit.com/r/neovim/comments/p206ju/magmanvim_interact_with_jupyter_from_neovim/
-- https://github.com/dccsillag/magma-nvim
-- ]]

-- TODO: zettels related
-- require 'zettels'

-- https://github.com/lewis6991/impatient.nvim
require("impatient")
require("globals")
require("vim")
require("plugins.treesitter")
require("plugins.filetype")

local vim = vim
local cmd = vim.cmd

vim.loop.new_timer():start(
	50,
	0,
	vim.schedule_wrap(function()
		-- nav
		-- cmd([[ packadd telescope.nvim ]])
		require("plugins.hop")
		-- TODO: https://github.com/ggandor/lightspeed.nvim
		-- cmd([[ packadd lightspeed.nvim ]])
		require("plugins.tmux")
		require("plugins.vim-test")
		cmd("packadd plenary.nvim")

		-- dev
		-- this should be loaded in order -- [[
		require("plugins.lsp")
		require("plugins.autopairs")
		require("plugins.luasnip")
		require("plugins.cmp")
		-- ]]

		require("plugins.neoformat")
		require("plugins.dap")

		-- utils
		-- require("plugins.zepl")
		require("plugins.dadbod")
		require("plugins.suda")

		-- view
		-- require("plugins.matchparen") -- TODO: fix
		require("plugins.buftabline")
		require("plugins.scrollview")
		-- require("plugins.zenmode")
		-- cmd([[ source ~/.config/nvim/vim/statusline.vim ]])

		-- edit
		require("plugins.comment")
		require("plugins.move")
		require("plugins.lion")
		require("plugins.autopairs")
		require("plugins.dial")

		-- git
		require("plugins.gitlinker")
		require("plugins.octo")
		require("plugins.git-messenger")
		require("plugins.gitsigns")

		-- misc
		-- cmd([[ execute 'silent! source ' . '~/.config/nvim/' . hostname() . '_lazy.vim' ]])

		-- require("plugins.numb")
		-- require("plugins.oscyank")

		require("plugins.telescope")
		-- require("plugins.harpoon")

		cmd("runtime! autoload/plugin/*")
		cmd("runtime! autoload/func/*")
		cmd("runtime! autoload/autocmd/*")
		cmd("runtime! autoload/command/*")
		cmd("runtime! autoload/map.vim")
	end)
)
