-- start
-- https://github.com/neovim/neovim/pull/27855/files

-- TODO: remove if updated
require("vim._core.ui2").enable({
	enable = true,
	msg = { target = "msg" },
})

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
vim.o.statusline = "%=%f"
vim.o.cmdheight = 0

-- https://github.com/neovim/neovim/issues/28801
-- vim.api.nvim_create_autocmd({ "ModeChanged" }, {
-- 	callback = function()
--         -- vim.o.laststatus = vim.o.laststatus
--         vim.cmd.redraw()
-- 	end,
-- })

-- autocmd ModeChanged * lua vim.schedule(function() vim.cmd('redraw') end)

