-- https://github.com/ruifm/gitlinker.nvim
vim.api.nvim_set_keymap('n', 'yl', '<cmd>packadd plenary.nvim | packadd gitlinker.nvim | lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', {silent = true})
