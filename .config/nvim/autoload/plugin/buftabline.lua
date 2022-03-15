-- vim.g.buftabline_show = 1
-- vim.g.buftabline_numbers = 2
--
vim.cmd([[
  " packadd vim-buftabline

  nmap <leader>1 <cmd>BufferGoto 1<cr>
  nmap <leader>2 <cmd>BufferGoto 2<cr>
  nmap <leader>3 <cmd>BufferGoto 3<cr>
  nmap <leader>4 <cmd>BufferGoto 4<cr>
  nmap <leader>5 <cmd>BufferGoto 5<cr>
  nmap <leader>6 <cmd>BufferGoto 6<cr>
  nmap <leader>7 <cmd>BufferGoto 7<cr>
  nmap <leader>8 <cmd>BufferGoto 8<cr>
  nmap <leader>9 <cmd>BufferGoto 9<cr>
  nmap <leader>0 <cmd>BufferLast<cr>

  nnoremap <silent> <A-[> :BufferMovePrevious<CR>
  nnoremap <silent> <A-]> :BufferMoveNext<CR>
]])

vim.g.bufferline = {
    auto_hide = true,
    closable = false,
    icons = "numbers",
    icon_separator_active = "",
    icon_separator_inactive = "",
    maximum_padding = 1,
}

vim.cmd([[
  " packadd nvim-web-devicons
  packadd barbar.nvim
]])
