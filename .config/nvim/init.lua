-- TODO: should be removed when merged to neovim core
-- https://github.com/lewis6991/impatient.nvim
require("impatient")

-- TODO jupyter integration
-- https://www.reddit.com/r/neovim/comments/p206ju/magmanvim_interact_with_jupyter_from_neovim/
-- https://github.com/dccsillag/magma-nvim

-- # debug
-- vim.lsp.set_log_level("debug")

require '_autocmds'
require '_vim'
require '_g'
require('plugins.vsnip')
require('plugins.lsp')
require('plugins.cmp')
require '_colors'

vim.cmd "source ~/.config/nvim/vim/autocmds.vim"

vim.loop.new_timer():start(50, 0, vim.schedule_wrap(function()

require 'plugins.treesitter'
require 'plugins.dap'
require 'plugins.dial'
require 'plugins._tmux'
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
require 'plugins.tcomment'
require 'plugins.scrollview'
require 'plugins.autopairs'
require 'plugins.oscyank'
require 'plugins.gitlinker'
require 'plugins.neoformat'
require 'plugins.vim-test'

vim.cmd [[
source ~/.config/nvim/vim/mapping.vim
source ~/.config/nvim/vim/zepl.vim
source ~/.config/nvim/vim/gina.vim
source ~/.config/nvim/vim/funcs.vim
source ~/.config/nvim/vim/visualstarsearch.vim
source ~/.config/nvim/vim/fzf.vim
source ~/.config/nvim/vim/autocmds_lazy.vim
source ~/.config/nvim/vim/startify.vim
source ~/.config/nvim/vim/sandwich.vim
source ~/.config/nvim/vim/quickrun.vim
source ~/.config/nvim/vim/vifm.vim
source ~/.config/nvim/vim/luapad.vim
]]

vim.cmd [[
packadd vim-fold-cycle
packadd pastefix.vim
packadd vim-fetch
packadd nvim-colorizer.lua
packadd codi.vim
packadd vim-characterize
packadd vim-eunuch
packadd vim-ReplaceWithRegister
packadd diffview.nvim
packadd vim-smoothie
packadd vim-scriptease
packadd vim-rfc
packadd vim-barbaric
]]

end))

vim.cmd [[
source ~/.config/nvim/vim/tmp.vim
]]
