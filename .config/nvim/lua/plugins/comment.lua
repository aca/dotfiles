vim.cmd [[ 
  packadd Comment.nvim 
  packadd nvim-ts-context-commentstring
]]

require('Comment').setup()
