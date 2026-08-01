vim.pack.add({ { src = 'https://github.com/aca/tmux.nvim' } })
require("tmux").setup({
    copy_sync = {
        enable = false,
    },
})
