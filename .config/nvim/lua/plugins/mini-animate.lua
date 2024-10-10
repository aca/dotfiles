vim.cmd.packadd "mini.nvim"
local animate = require('mini.animate')
animate.setup({
    cursor = {
        enable = false,
    },
    resize = {
        enable = false,
    },
    open = {
        enable = false,
    },
    close = {
        enable = false,
    },
    scroll = {
        -- timing = 100,
       timing = animate.gen_timing.linear({ duration = 80, unit = 'total' }),
    }
})
