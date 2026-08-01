-- settings that is required at start, if not put it in lazy/

local vim = vim
local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.wrap = false
vim.opt.wrapscan = false
vim.opt.wrapmargin = 0
vim.opt.signcolumn = "no"

vim.opt.mmp = 50000
vim.opt.wildignore = { "/tmp/*", "*.so", "*.swp", "*.zip", "*.pyc", "*.db", "*.sqlite", "*.git/*" }
vim.o.conceallevel = 2
vim.o.shortmess = "aItcF"
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.diffopt = {
	"internal",
	"filler",
	"closeoff",
	"hiddenoff",
	"algorithm:histogram",
	"vertical",
	"linematch:60",
	"indent-heuristic",
}

-- fold
opt.foldlevel = 99
opt.foldlevelstart = 99
-- opt.foldnestmax = 7

opt.swapfile = false
opt.shada = { "!", "'1000", "<50", "s10", "h" }
opt.hidden = true -- zepl.vim

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.modelineexpr = true
opt.showcmd = false
opt.showmode = false

-- disable default vim stuffs for faster startuptime
-- vim.g.loaded_clipboard_provider = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_syntax = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_ftplugin = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
