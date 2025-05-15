-- https://github.com/neovim/neovim/pull/27855/files
require('vim._extui').enable({
 enable = true, -- Whether to enable or disable the UI.
 msg = { -- Options related to the message module.
   ---@type 'box'|'cmd' Type of window used to place messages, either in the
   ---cmdline or in a separate message box window with ephemeral messages.
   pos = 'cmd',
   box = { -- Options related to the message box window.
     timeout = 2000, -- Time a message is visible.
   },
 },
})

    -- require('vim._extui').enable({
    --  enable = true, -- Whether to enable or disable the UI.
    --  msg = { -- Options related to the message module.
    --    ---@type 'box'|'cmd' Type of window used to place messages, either in the
    --    ---cmdline or in a separate message box window with ephemeral messages.
    --    pos = 'cmd',
    --    box = { -- Options related to the message box window.
    --      timeout = 4000, -- Time a message is visible.
    --    },
    --  },
    -- })

vim.o.statuscolumn="%@SignCb@%s%=%T%@NumCb@%l │%T "
vim.o.statusline = "%<%f %h%m%r"
vim.o.cmdheight = 0

-- vim.o.laststatus = vim.o.laststatus

-- https://github.com/neovim/neovim/issues/28801
-- vim.api.nvim_create_autocmd({ "ModeChanged" }, {
-- 	callback = function()
--         -- vim.o.laststatus = vim.o.laststatus
--         vim.cmd.redraw()
-- 	end,
-- })


-- autocmd ModeChanged * lua vim.schedule(function() vim.cmd('redraw') end)

-- vim.print("reset laststatus")
-- vim.o.laststatus = vim.o.laststatus
