vim.cmd([[
  packadd hop.nvim
  nmap <silent><leader>w :HopWord<cr>
]])

require("hop").setup()
