vim.g.swap_no_default_key_mappings = 1
vim.cmd([[
  packadd vim-swap
  nmap g< <Plug>(swap-prev)
  nmap g> <Plug>(swap-next)
]])
