-- https://github.com/lewis6991/gitsigns.nvim
vim.cmd [[
  packadd gitsigns.nvim
]]

require("gitsigns").setup {
    signs = {
        add = {hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"},
        change = {hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"},
        delete = {hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
        topdelete = {hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
        changedelete = {hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"}
    },
    numhl = false,
    linehl = false,
    signcolumn = true,
    keymaps = {
        -- Default keymap options
        noremap = false,
        buffer = true,
        ["n ]h"] = {expr = true, '&diff ? \']c\' : \'<cmd>lua require"gitsigns.actions".next_hunk()<CR>\''},
        ["n [h"] = {expr = true, '&diff ? \'[c\' : \'<cmd>lua require"gitsigns.actions".prev_hunk()<CR>\''},

        ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
        ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
        ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
    },
    watch_index = {
        interval = 1000
    },
    -- current_line_blame = false,
    -- current_line_blame_delay = 1000,
    -- current_line_blame_position = "eol",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    use_internal_diff = true -- If luajit is present
}
