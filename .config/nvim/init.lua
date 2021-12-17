-- OPT [[
-- vim.lsp.set_log_level("debug")
-- require('vim.lsp.log').set_format_func(vim.inspect)
-- ]]

-- UPDATE [[
-- :TSInstall all
-- :TSUpdate all
-- ]]

require("vim")


-- TODO: jupyter integration [[
-- https://www.reddit.com/r/neovim/comments/p206ju/magmanvim_interact_with_jupyter_from_neovim/
-- https://github.com/dccsillag/magma-nvim
-- ]]

-- TODO: impatient.nvim should be removed when merged to neovim core [[
-- impatient.nvim should be removed when merged to neovim core
-- https://github.com/lewis6991/impatient.nvim
-- https://github.com/neovim/neovim/pull/15436
-- ]]
require("impatient")
-- require("impatient").enable_profile()
-- :LuaCacheClear

-- TODO: zettels related
-- require 'zettels'



require("plugins.treesitter")
vim.loop.new_timer():start(
	0,
	0,
	vim.schedule_wrap(function()
		vim.cmd([[ source ~/.config/nvim/vim/fzf.vim ]])

		vim.cmd([[ packadd nvim-lspconfig ]])
    require("plugins.lsp")
    require("plugins.autopairs")


		require("plugins.tmux")
		vim.cmd([[ packadd plenary.nvim ]])
		vim.cmd([[ source ~/.config/nvim/vim/statusline.vim ]])
    vim.cmd([[ source ~/.config/nvim/vim/vifm.vim ]])

    require("plugins.comment")

		-- require("plugins.zepl")
		-- require("plugins.git-messenger")
		-- require("plugins.scrollview")

		vim.cmd([[ source ~/.config/nvim/vim/mapping.vim ]])
		-- vim.cmd([[ source ~/.config/nvim/vim/luapad.vim ]])
		-- vim.cmd([[ source ~/.config/nvim/vim/smoothie.vim ]])
		-- vim.cmd([[ source ~/.config/nvim/vim/codi.vim ]])
		-- vim.cmd [[ source ~/.config/nvim/vim/projectionist.vim ]]

		-- vim.cmd([[ packadd harpoon ]])
		-- vim.cmd([[ packadd vim-gtfo ]])
	end)
)

vim.cmd([[ autocmd CursorHold * lua require("plugins._lazy") ]])
vim.cmd([[ autocmd InsertEnter * lua require("plugins.cmp")]])
    
