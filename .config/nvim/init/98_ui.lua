-- start
-- https://github.com/neovim/neovim/pull/27855/files

-- vim.defer_fn(function()
-- 	-- vim.cmd([[ silent! helptags ALL ]])
--     require('vim._extui').enable({
--      enable = true, -- Whether to enable or disable the UI.
--      msg = { -- Options related to the message module.
--        ---@type 'box'|'cmd' Type of window used to place messages, either in the
--        ---cmdline or in a separate message box window with ephemeral messages.
--        pos = 'cmd',
--        box = { -- Options related to the message box window.
--          timeout = 2000, -- Time a message is visible.
--        },
--      },
--     })
-- end, 200)

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


vim.o.wrap = false
-- vim.o.showtabline = 2
vim.o.relativenumber = true
-- vim.o.signcolumn = "yes:1"
-- vim.o.signcolumn = "yes:1"
vim.o.formatoptions = "jncroql"
vim.o.fillchars = "eob: ,fold: ,foldclose:▸,foldopen:▾,stl: "

vim.o.number = false
vim.o.relativenumber = false
-- vim.o.numberwidth = 3
-- vim.o.statuscolumn = "%@SignCb@%s%=%T%@NumCb@%l │%T "
-- vim.o.statusline = "%<%f %h%m%r"
vim.o.statusline = "%=%f"
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
--
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.bo.filetype = "terminal"
	end,
})

-- Then: configure settings for that filetype
vim.api.nvim_create_autocmd("FileType", {
	pattern = "terminal",
	callback = function()
		vim.wo.relativenumber = false
		vim.wo.number = false
		vim.wo.signcolumn = "no"
		vim.wo.statuscolumn = ""
	end,
})

    -- au TermOpen * tnoremap <Esc> <c-\><c-n>
-- vim.cmd([[
--     au TermOpen * tnoremap <c-l> <c-\><c-w>l
--     au TermOpen * tnoremap <c-h> <c-\><c-w>h
-- ]])

-- vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
-- vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])


vim.keymap.set('n', 'gf', [[gF]])
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { buffer = true })
    vim.keymap.set('t', '<c-h>', [[<C-\><C-n><c-w>h]], { buffer = true })
    vim.keymap.set('t', '<c-l>', [[<C-\><C-n><c-w>l]], { buffer = true })
    vim.cmd('startinsert')
    -- vim.keymap.set('t', '<c-l>', '<C-\\><C-n><c-l><c-h>', { buffer = true })
    -- vim.keymap.set('t', '<c-h>', '<C-\\><C-n><c-h><c-h>', { buffer = true })
  end,
})
