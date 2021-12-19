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

require("vim")
require("plugins.treesitter")

local cmd = vim.cmd
vim.loop.new_timer():start(
	0,
	0,
	vim.schedule_wrap(function()
    -- nav
		cmd([[ source ~/.config/nvim/vim/fzf.vim ]])
    cmd([[ source ~/.config/nvim/vim/visualstarsearch.vim ]])
    cmd([[ packadd clever-f.vim ]])
    cmd([[ packadd vim-fetch ]])
    cmd([[ source ~/.config/nvim/vim/smoothie.vim ]])
    cmd([[ source ~/.config/nvim/vim/startify.vim ]])
		cmd([[ source ~/.config/nvim/vim/vifm.vim ]])
    -- cmd([[ packadd telescope.nvim ]])
    cmd([[ packadd vim-fold-cycle ]])

    require("plugins.hop") 
    -- TODO: https://github.com/ggandor/lightspeed.nvim
    -- cmd([[ packadd lightspeed.nvim ]])
		require("plugins.tmux")
    require("plugins.vim-test")
    cmd([[ packadd vim-dirvish ]])

    -- dev
		cmd([[ packadd nvim-lspconfig ]])
		require("plugins.lsp")
		require("plugins.autopairs")
    cmd([[ packadd symbols-outline.nvim ]])
    require("plugins.cmp")
    require("plugins.neoformat")
    require("plugins.dap")
    cmd([[ packadd plenary.nvim ]])


    -- utils
    -- require("plugins.zepl")
    cmd([[ packadd vim-characterize ]])
    require("plugins.dadbod")
    -- cmd([[ source ~/.config/nvim/vim/codi.vim ]])
    cmd([[ source ~/.config/nvim/vim/quickrun.vim ]])

    cmd([[ source ~/.config/nvim/vim/funcs.vim ]])
    cmd([[ packadd vim-eunuch ]])
    -- cmd([[ packadd vim-rfc ]])
    cmd([[ packadd nvim-colorizer.lua ]])
    cmd([[ source ~/.config/nvim/vim/barbaric.vim ]])
    require("plugins.suda")

    -- view
    -- require("plugins.matchparen") -- TODO: fix 
    require("plugins.buftabline")
    require("plugins.scrollview")
    -- require("plugins.zenmode")
		cmd([[ source ~/.config/nvim/vim/statusline.vim ]])
    cmd([[ packadd diffview.nvim ]])

    -- edit
		require("plugins.comment")
    require("plugins.move")
    cmd([[ packadd vim-ReplaceWithRegister ]])
    require("plugins.lion")
    cmd([[ source ~/.config/nvim/vim/sandwich.vim ]])
    require("plugins.autopairs")
    require("plugins.dial")

    -- lazyload default plugins
    cmd([[ source ~/.config/nvim/vim/netrw.vim ]])
    cmd([[ source ~/.config/nvim/vim/matchit.vim ]])

    -- git
    cmd([[ source ~/.config/nvim/vim/gina.vim ]])
    require("plugins.gitlinker")
		require("plugins.git-messenger")
    require("plugins.gitsigns")
    cmd([[ packadd git-worktree.nvim ]])

    -- vim
    cmd([[ source ~/.config/nvim/vim/luapad.vim ]])
    cmd([[ packadd vim-scriptease ]])

    -- misc
    cmd([[ source ~/.config/nvim/vim/autocmds_lazy.vim ]])
		cmd([[ source ~/.config/nvim/vim/mapping.vim ]])
		-- vim.cmd [[ source ~/.config/nvim/vim/projectionist.vim ]]
		-- vim.cmd([[ packadd harpoon ]])
		-- vim.cmd([[ packadd vim-gtfo ]])
    cmd([[ execute 'silent! source ' . '~/.config/nvim/' . hostname() . '_lazy.vim' ]])
    -- require("plugins.numb")
    -- require("plugins.oscyank")
    cmd([[ packadd todo-comments.nvim ]])

	end)
)

vim.cmd([[ autocmd InsertEnter * lua require("plugins._lazy") ]])
