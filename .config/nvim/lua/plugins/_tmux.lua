-- vim.cmd [[
-- packadd vim-tmux-navigator
-- nnoremap <c-h> :TmuxNavigateLeft<cr>
-- nnoremap <c-j> :TmuxNavigateDown<cr>
-- nnoremap <c-k> :TmuxNavigateUp<cr>
-- nnoremap <c-l> :TmuxNavigateRight<cr>
--
-- tnoremap <c-h> <C-\><C-N><cmd>TmuxNavigateLeft<cr>
-- tnoremap <c-j> <C-\><C-N><cmd>TmuxNavigateDown<cr>
-- tnoremap <c-k> <C-\><C-N><cmd>TmuxNavigateUp<cr>
-- tnoremap <c-l> <C-\><C-N><cmd>TmuxNavigateRight<cr>
-- ]]
--
-- vim.cmd [[
--   packadd better-vim-tmux-resizer
--   let g:tmux_resizer_no_mappings = 1
--   nnoremap <silent> <m-h> <cmd>TmuxResizeLeft<cr>
--   nnoremap <silent> <m-j> <cmd>TmuxResizeDown<cr>
--   nnoremap <silent> <m-k> <cmd>TmuxResizeUp<cr>
--   nnoremap <silent> <m-l> <cmd>TmuxResizeRight<cr>
-- ]]
--

require("tmux").setup({
    -- overwrite default configuration
    -- here, e.g. to enable default bindings
    copy_sync = {
        -- enables copy sync and overwrites all register actions to
        -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
        enable = false,
    },
    navigation = {
        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = true,
    },
    resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = true,
    }
})
