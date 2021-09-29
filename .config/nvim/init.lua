
-- TODO jupyter integration
-- https://www.reddit.com/r/neovim/comments/p206ju/magmanvim_interact_with_jupyter_from_neovim/
-- https://github.com/dccsillag/magma-nvim

-- # debug
-- vim.lsp.set_log_level("debug")


-- TODO: should be removed when merged to neovim core
-- https://github.com/lewis6991/impatient.nvim
-- https://github.com/neovim/neovim/pull/15436
-- require("impatient").enable_profile()
require("impatient")

require '_vim'
require '_g'
require('plugins.lsp')

-- vim.cmd [[ packadd coq_nvim ]]
require('plugins.vsnip')
require('plugins.cmp')

vim.cmd [[ 
source ~/.config/nvim/vim/colors.vim 
source ~/.config/nvim/vim/autocmds.vim
]]

vim.loop.new_timer():start(0, 0, vim.schedule_wrap(function()
require 'plugins.treesitter'
require 'plugins.dap'
require 'plugins.dial'
require 'plugins._tmux'
require 'plugins.gitsigns'

require 'plugins.zenmode'
require 'plugins.xdg_open'
-- require 'plugins.numb'
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
require 'plugins.dadbod'

vim.cmd [[
source ~/.config/nvim/vim/statusline.vim
source ~/.config/nvim/vim/mapping.vim
" source ~/.config/nvim/vim/zepl.vim
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
source ~/.config/nvim/vim/smoothie.vim
source ~/.config/nvim/vim/barbaric.vim
" source ~/.config/nvim/vim/codi.vim
]]

vim.cmd [[
packadd vim-fold-cycle
packadd vim-fetch
packadd nvim-colorizer.lua
packadd vim-characterize
packadd vim-eunuch
packadd vim-ReplaceWithRegister
packadd diffview.nvim
packadd vim-scriptease
packadd vim-rfc
packadd telescope.nvim
packadd todo-comments.nvim
]]

end))

vim.cmd [[ source ~/.config/nvim/vim/tmp.vim ]]

