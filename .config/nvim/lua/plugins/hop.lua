vim.cmd([[
  packadd hop.nvim
  nmap <silent>s :HopWord<cr>
]])

require("hop").setup()
