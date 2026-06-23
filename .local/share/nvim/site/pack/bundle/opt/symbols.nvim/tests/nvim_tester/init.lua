-- Add current directory to 'runtimepath' to be able to use 'lua' files
vim.cmd("let &rtp.=','.getcwd()")

vim.cmd("set rtp+=tests/nvim_tester")
require("mini").setup()
