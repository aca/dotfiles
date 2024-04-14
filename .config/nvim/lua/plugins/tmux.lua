vim.cmd.packadd 'tmux.nvim'
require("tmux").setup({
    copy_sync = {
        enable = false,
    },
})

-- TODO: https://github.com/aserowy/tmux.nvim/issues/105
-- cmdline 이 남아있는 것 같음
-- statusline 이 사라짐 뭐지?

-- vim.cmd([[
-- packadd vim-tmux-navigator
-- nnoremap <silent><c-h> <cmd>TmuxNavigateLeft<cr>
-- nnoremap <silent><c-j> <cmd>TmuxNavigateDown<cr>
-- nnoremap <silent><c-k> <cmd>TmuxNavigateUp<cr>
-- nnoremap <silent><c-l> <cmd>TmuxNavigateRight<cr>
-- tnoremap <c-h> <C-\><C-N><cmd>TmuxNavigateLeft<cr>
-- tnoremap <c-j> <C-\><C-N><cmd>TmuxNavigateDown<cr>
-- tnoremap <c-k> <C-\><C-N><cmd>TmuxNavigateUp<cr>
-- tnoremap <c-l> <C-\><C-N><cmd>TmuxNavigateRight<cr>
-- ]])
-- 
-- vim.cmd([[
-- packadd better-vim-tmux-resizer
-- let g:tmux_resizer_no_mappings = 1
-- nnoremap <silent> <m-h> <cmd>TmuxResizeLeft<cr>
-- nnoremap <silent> <m-j> <cmd>TmuxResizeDown<cr>
-- nnoremap <silent> <m-k> <cmd>TmuxResizeUp<cr>
-- nnoremap <silent> <m-l> <cmd>TmuxResizeRight<cr>
-- ]])

-- vim.cmd.packadd 'vim-kitty-navigator'


