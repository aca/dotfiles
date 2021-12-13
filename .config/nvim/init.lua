-- OPT [[
-- vim.lsp.set_log_level("debug")
-- require('vim.lsp.log').set_format_func(vim.inspect)
-- ]]
--
-- UPDATE [[
-- :TSInstall all
-- :TSUpdate all
-- ]]

-- TODO: add treesitter https://github.com/MDeiml/tree-sitter-markdown
-- TODO: jupyter integration [[
-- https://www.reddit.com/r/neovim/comments/p206ju/magmanvim_interact_with_jupyter_from_neovim/
-- https://github.com/dccsillag/magma-nvim
--
-- ]]
-- TODO: impatient.nvim should be removed when merged to neovim core [[
-- impatient.nvim should be removed when merged to neovim core
-- https://github.com/lewis6991/impatient.nvim
-- https://github.com/neovim/neovim/pull/15436
-- ]]

-- require("impatient").enable_profile()
-- :LuaCacheClear
require("impatient")

-- require("_vim")
-- require("_g")

-- TODO: remove when it's merged to core
-- require("plugins.filetype")
-- require("plugins.vsnip")
-- require("plugins.lsp")

-- TODO
-- require("filetype").setup({
--
-- 	overrides = {
-- 		extensions = {
-- 			-- Set the filetype of *.pn files to potion
-- 			elv = "elvish",
-- 		},
-- 		shebang = {
-- 			bash = "bash",
--       raku = "raku",
-- 		},
-- 	},
-- })

-- TODO: zettels related
-- require 'zettels'

vim.g._uname = "Linux"
if vim.call("has", "mac") then
	vim.g._uname = "macOS"
end

-- run in minimal mode
vim.g._minimal = os.getenv("USER") ~= "rok"

-- vim.cmd([[ packadd orgmode.nvim ]])

vim.loop.new_timer():start(
	200,
	0,
	vim.schedule_wrap(function()
		require("plugins.tmux")
		require("plugins.treesitter")
		require("plugins.autopairs")
		require("plugins.cmp")
		require("plugins.dap")
		require("plugins.dial")
		require("plugins.gitsigns")
		require("plugins.zenmode")
		require("plugins.xdg_open")
		require("plugins.numb")
		require("plugins.hop")
		require("plugins.lion")
		require("plugins.move")
		require("plugins.suda")
		require("plugins.zepl")
		require("plugins.git-messenger")
		require("plugins.buftabline")
		require("plugins.comment")
		require("plugins.scrollview")
		require("plugins.oscyank")
		require("plugins.gitlinker")
		require("plugins.neoformat")
		require("plugins.vim-test")
		require("plugins.dadbod")

		vim.cmd([[ source ~/.config/nvim/vim/fzf.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/autocmds_lazy.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/mapping.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/zepl.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/gina.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/funcs.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/visualstarsearch.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/startify.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/sandwich.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/quickrun.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/vifm.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/luapad.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/barbaric.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/smoothie.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/statusline.vim ]])
		vim.cmd([[ source ~/.config/nvim/vim/codi.vim ]])
		-- vim.cmd [[ source ~/.config/nvim/vim/projectionist.vim ]]

		vim.cmd([[ packadd vim-fold-cycle ]])
		vim.cmd([[ packadd nvim-colorizer.lua ]])
		vim.cmd([[ packadd vim-characterize ]])
		vim.cmd([[ packadd vim-eunuch ]])
		vim.cmd([[ packadd vim-ReplaceWithRegister ]])
		vim.cmd([[ packadd diffview.nvim ]])
		vim.cmd([[ packadd vim-scriptease ]])
		vim.cmd([[ packadd vim-rfc ]])
		vim.cmd([[ packadd telescope.nvim ]])
		vim.cmd([[ packadd todo-comments.nvim ]])
		vim.cmd([[ packadd clever-f.vim ]])
		vim.cmd([[ packadd vim-fetch ]])
		vim.cmd([[ packadd git-worktree.nvim ]])
		vim.cmd([[ packadd symbols-outline.nvim ]])

		vim.cmd([[ packadd harpoon ]])

		vim.cmd([[ execute 'silent! source ' . '~/.config/nvim/' . hostname() . '_lazy.vim' ]])
	end)
)
