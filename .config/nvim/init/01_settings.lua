local vim = vim
local g = vim.g
local opt = vim.opt
local o = vim.o

-- vim.opt.wrap = false
vim.o.showtabline = 2
vim.o.number = true
vim.o.relativenumber = true
-- vim.o.numberwidth = 5
-- o.signcolumn = "yes:1"
vim.o.signcolumn = "yes:1"
-- o.formatoptions = "jncroql"
vim.o.fillchars = "eob: ,fold: ,foldclose:▸,foldopen:▾,stl: "

-- https://github.com/neovim/neovim/pull/25872

-- o.fencs = "euc-kr"
-- o.fencs = "ucs-bom,utf-8,default,latin1"
-- vim.o.fencs="ucs-bom,utf-8,cp949,euc-kr,default,latin1"


-- o. = "%= %m%r%h%w %l:%c %P "
-- o.statusline = "%= %m%r%h%w %l:%c %P "

-- _G.wordcount__visual_words = function()
--     local wordcount = vim.fn.wordcount()["visual_bytes"]
--     if wordcount == nil then
--         return ""
--     else
--         return wordcount
--     end
-- end
-- o.statusline = "%{%v:lua.wordcount__visual_words()%}%=%l/%L"

vim.o.tabline = " "
-- vim.o.statusline = "%t"
-- opt.winbar = "%=%l:%c %P %m%f"
-- opt.winbar = " "

-- o.mmp = 50000
-- o.shell = "/bin/sh"
vim.opt.wildignore = { "/tmp/*", "*.so", "*.swp", "*.zip", "*.pyc", "*.db", "*.sqlite", "*.git/*" }
-- o.conceallevel = 3
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
-- opt.lazyredraw = false -- noice.nvim

-- opt.cursorcolumn = false
-- opt.cursorline = true
-- opt.timeoutlen = 500

-- fold
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 7

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

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable default vim stuffs for faster startuptime
vim.g.loaded_2html_plugin = 1
vim.g.loaded_syntax = 1
vim.g.loaded_clipboard_provider = 1
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
