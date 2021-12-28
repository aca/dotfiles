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

local vim = vim
local g = vim.g
local cmd = vim.cmd

-- https://github.com/lewis6991/impatient.nvim
require("impatient")
require("globals")
require("vim")
if not g._minimal then
	require("plugins.filetype")
end

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
		cmd("packadd plenary.nvim")

		if not g._minimal then
			require("plugins.treesitter")
			require("plugins.lsp")
			require("plugins.autopairs")
			require("plugins.luasnip")
			require("plugins.cmp")

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
			require("plugins.telescope")
			require("plugins.vim-test")
		end

		-- view
		-- require("plugins.matchparen") -- TODO: fix
		-- cmd([[ source ~/.config/nvim/vim/statusline.vim ]])

		-- misc
		-- cmd([[ execute 'silent! source ' . '~/.config/nvim/' . hostname() . '_lazy.vim' ]])

		-- require("plugins.numb")

		-- require("plugins.harpoon")

		cmd("runtime! autoload/plugin/*")
		cmd("runtime! autoload/func/*")
		cmd("runtime! autoload/autocmd/*")
		cmd("runtime! autoload/command/*")
		cmd("runtime! autoload/map/*")
		cmd("runtime! autoload/lib/*")
	end)
)
