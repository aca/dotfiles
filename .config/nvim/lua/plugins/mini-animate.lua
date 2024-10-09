vim.cmd.packadd "mini.nvim"
local animate = require('mini.animate')
animate.setup({
    -- cursor = {
    --    timing = animate.gen_timing.linear({ duration = 80, unit = 'total' }),
    -- },
    scroll = {
        -- timing = 100,
       timing = animate.gen_timing.linear({ duration = 80, unit = 'total' }),
    }
})
