vim.cmd([[
  packadd hop.nvim
  nmap <silent><leader>w :HopWord<cr>
  nmap <silent>s :HopChar1<cr>
]])

require("hop").setup()
