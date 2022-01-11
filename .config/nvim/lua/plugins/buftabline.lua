-- vim.g.buftabline_show = 1
-- vim.g.buftabline_numbers = 2
--
-- vim.cmd([[
--   packadd vim-buftabline
--
--   nmap <leader>1 <Plug>BufTabLine.Go(1)
--   nmap <leader>2 <Plug>BufTabLine.Go(2)
--   nmap <leader>3 <Plug>BufTabLine.Go(3)
--   nmap <leader>4 <Plug>BufTabLine.Go(4)
--   nmap <leader>5 <Plug>BufTabLine.Go(5)
--   nmap <leader>6 <Plug>BufTabLine.Go(6)
--   nmap <leader>7 <Plug>BufTabLine.Go(7)
--   nmap <leader>8 <Plug>BufTabLine.Go(8)
--   nmap <leader>9 <Plug>BufTabLine.Go(9)
--   nmap <leader>0 <Plug>BufTabLine.Go(10)
-- ]])

vim.g.bufferline = {
	auto_hide = true,
	closable = false,
}

vim.cmd([[
  packadd nvim-web-devicons
  packadd barbar.nvim
]])
