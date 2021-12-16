require("plugins.autopairs")
require("plugins.gitsigns")
require("plugins.buftabline")
require("plugins.dial")
require("plugins.gitlinker")
require("plugins.dap")
require("plugins.matchparen")
require("plugins.oscyank")
require("plugins.neoformat")
require("plugins.vim-test")
require("plugins.dadbod")
require("plugins.numb")
require("plugins.hop")
require("plugins.lion")
require("plugins.move")

vim.cmd([[ source ~/.config/nvim/vim/autocmds_lazy.vim ]])
vim.cmd([[ source ~/.config/nvim/vim/gina.vim ]])
vim.cmd([[ source ~/.config/nvim/vim/funcs.vim ]])
vim.cmd([[ source ~/.config/nvim/vim/visualstarsearch.vim ]])

vim.cmd([[ source ~/.config/nvim/vim/startify.vim ]])

vim.cmd([[ source ~/.config/nvim/vim/sandwich.vim ]])
vim.cmd([[ source ~/.config/nvim/vim/quickrun.vim ]])
vim.cmd([[ source ~/.config/nvim/vim/vifm.vim ]])

vim.cmd([[ packadd vim-fold-cycle ]])
vim.cmd([[ packadd vim-characterize ]])
vim.cmd([[ packadd vim-eunuch ]])
vim.cmd([[ packadd vim-ReplaceWithRegister ]])
vim.cmd([[ packadd diffview.nvim ]])
vim.cmd([[ packadd vim-scriptease ]])
-- vim.cmd([[ packadd vim-rfc ]])
vim.cmd([[ packadd telescope.nvim ]])
-- vim.cmd([[ packadd todo-comments.nvim ]])
vim.cmd([[ packadd clever-f.vim ]])
vim.cmd([[ packadd vim-fetch ]])
vim.cmd([[ packadd symbols-outline.nvim ]])
vim.cmd([[ packadd vim-dirvish ]])

vim.cmd([[ source ~/.config/nvim/vim/barbaric.vim ]])
vim.cmd([[ packadd nvim-colorizer.lua ]])
vim.cmd([[ packadd git-worktree.nvim ]])
vim.cmd([[
  unlet g:loaded_netrwPlugin
  source /usr/local/share/nvim/runtime/plugin/netrwPlugin.vim
  unlet g:loaded_matchit
  source /usr/local/share/nvim/runtime/plugin/matchit.vim
]])

vim.cmd([[ execute 'silent! source ' . '~/.config/nvim/' . hostname() . '_lazy.vim' ]])

require("plugins.comment")
require("plugins.zenmode")
require("plugins.suda")

require("funcs")
