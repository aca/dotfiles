-- OPT [[

-- vim.lsp.set_log_level("debug")
-- require('vim.lsp.log').set_format_func(vim.inspect)

-- ]]

-- TODO [[

-- jupyter integration
-- https://www.reddit.com/r/neovim/comments/p206ju/magmanvim_interact_with_jupyter_from_neovim/
-- https://github.com/dccsillag/magma-nvim

-- should be removed when merged to neovim core
-- https://github.com/lewis6991/impatient.nvim
-- https://github.com/neovim/neovim/pull/15436

-- ]]

-- require("impatient").enable_profile()
require "impatient"
require '_vim'
require '_g'

require 'plugins.vsnip'
require 'plugins.lsp'
-- require 'zettels' -- TODO

vim.cmd [[ source ~/.config/nvim/vim/colors.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/autocmds.vim ]]

vim.cmd [[ packadd orgmode.nvim ]]

vim.loop.new_timer():start(0, 0, vim.schedule_wrap(function()
require 'plugins.tmux'
require 'plugins.treesitter'
require 'plugins.autopairs'
require 'plugins.cmp'
require 'plugins.dap'
require 'plugins.dial'
require 'plugins.gitsigns'
require 'plugins.zenmode'
require 'plugins.xdg_open'
require 'plugins.numb'
require 'plugins.hop'
require 'plugins.lion'
require 'plugins.move'
require 'plugins.suda'
require 'plugins.zepl'
require 'plugins.git-messenger'
require 'plugins.buftabline'
require 'plugins.comment'
require 'plugins.scrollview'
require 'plugins.oscyank'
require 'plugins.gitlinker'
require 'plugins.neoformat'
require 'plugins.vim-test'
require 'plugins.dadbod'

vim.cmd [[ source ~/.config/nvim/vim/fzf.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/autocmds_lazy.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/mapping.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/zepl.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/gina.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/funcs.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/visualstarsearch.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/startify.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/sandwich.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/quickrun.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/vifm.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/luapad.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/barbaric.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/smoothie.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/statusline.vim ]]
-- vim.cmd [[ source ~/.config/nvim/vim/projectionist.vim ]]
vim.cmd [[ source ~/.config/nvim/vim/codi.vim ]]
vim.cmd [[ packadd vim-fold-cycle ]]
vim.cmd [[ packadd nvim-colorizer.lua ]]
vim.cmd [[ packadd vim-characterize ]]
vim.cmd [[ packadd vim-eunuch ]]
vim.cmd [[ packadd vim-ReplaceWithRegister ]]
vim.cmd [[ packadd diffview.nvim ]]
vim.cmd [[ packadd vim-scriptease ]]
vim.cmd [[ packadd vim-rfc ]]
vim.cmd [[ packadd telescope.nvim ]]
vim.cmd [[ packadd todo-comments.nvim ]]
vim.cmd [[ packadd clever-f.vim ]]
vim.cmd [[ packadd vim-fetch ]]

vim.cmd [[ execute 'silent! source ' . '~/.config/nvim/' . hostname() . '_lazy.vim' ]]
end))

