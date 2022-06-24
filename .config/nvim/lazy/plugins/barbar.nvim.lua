local nvim_set_keymap = vim.api.nvim_set_keymap
nvim_set_keymap('n', '<leader>1', '<cmd>BufferGoto 1<cr>', {noremap = true})
nvim_set_keymap('n', '<leader>2', '<cmd>BufferGoto 2<cr>', {noremap = true})
nvim_set_keymap('n', '<leader>3', '<cmd>BufferGoto 3<cr>', {noremap = true})
nvim_set_keymap('n', '<leader>4', '<cmd>BufferGoto 4<cr>', {noremap = true})
nvim_set_keymap('n', '<leader>5', '<cmd>BufferGoto 5<cr>', {noremap = true})
nvim_set_keymap('n', '<leader>6', '<cmd>BufferGoto 6<cr>', {noremap = true})
nvim_set_keymap('n', '<leader>7', '<cmd>BufferGoto 7<cr>', {noremap = true})
nvim_set_keymap('n', '<leader>8', '<cmd>BufferGoto 8<cr>', {noremap = true})
nvim_set_keymap('n', '<leader>9', '<cmd>BufferGoto 9<cr>', {noremap = true})
nvim_set_keymap('n', '<leader>0', '<cmd>BufferGotoLast<cr>', {noremap = true})

vim.g.bufferline = {
    auto_hide = true,
    closable = false,
    icons = "numbers",
    icon_separator_active = "",
    icon_separator_inactive = "",
    maximum_padding = 1,
}

vim.cmd([[
  packadd barbar.nvim
]])
