vim.cmd.packadd "smear-cursor.nvim"

require('smear_cursor').setup({
    opts = {                         -- Default  Range
      stiffness = 0.9,               -- 0.6      [0, 1]
      trailing_stiffness = 0.1,      -- 0.3      [0, 1]
      distance_stop_animating = 0.9, -- 0.1      > 0
    },
})
