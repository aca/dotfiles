vim.cmd([[
  packadd hop.nvim
  nmap <silent>w :HopWord<cr>
]])

require("hop").setup()
