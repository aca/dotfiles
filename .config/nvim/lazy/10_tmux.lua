vim.cmd.packadd 'tmux.nvim'
require("tmux").setup({
    copy_sync = {
        enable = false,
    },
})
