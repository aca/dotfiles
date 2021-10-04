vim.cmd([[
  packadd hop.nvim
  nmap <silent><Leader>w :HopWord<cr>
]])

require("hop").setup()
