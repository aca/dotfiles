local vim = vim
local g = vim.g
local opt = vim.opt
local o = vim.o

vim.o.splitkeep = "screen"
o.formatoptions = "jncroql"
o.fillchars = "eob: ,fold: ,foldclose:▸,foldopen:▾,stl: "
o.clipboard = "unnamedplus"
o.signcolumn = "no"

o.cmdheight = 0
o.laststatus = 0

-- o.statusline = "%= %m%r%h%w %l:%c %P "
-- opt.winbar = "%=%l:%c %P %m%f"

o.mmp = 5000
o.shell = "/bin/sh"
opt.wildignore = { "/tmp/*", "*.so", "*.swp", "*.zip", "*.pyc", "*.db", "*.sqlite", "*.git/*" }
o.conceallevel = 2
o.shortmess = "aItcF"
-- opt.clipboard = { "unnamed", "unnamedplus" }
-- o.virtualedit = "block"
opt.nrformats = { "bin", "hex", "alpha", "octal" }

opt.isfname = opt.isfname - "=" -- fix gf for file_path=path/to/file.txt
opt.termguicolors = true

opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }
opt.completeopt = { "menu", "menuone", "noselect" }

opt.wrapmargin = 0
opt.lazyredraw = true

opt.cursorcolumn = false
opt.cursorline = true
opt.timeoutlen = 500

-- fold
-- opt.foldmethod="syntax"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 2

opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.updatetime = 1000 -- Make updates happen faster
opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor

opt.inccommand = "split"
opt.swapfile = false
opt.shada = { "!", "'1000", "<50", "s10", "h" }
opt.hidden = true -- zepl.vim

opt.joinspaces = false
opt.belloff = "all"

o.number = false
opt.relativenumber = false

-- Tabs
-- opt.autoindent = true
-- opt.cindent = true

opt.cinkeys = opt.cinkeys - "0#" -- https://vim.fandom.com/wiki/Restoring_indent_after_typing_hash
opt.wrap = false
opt.wrapscan = false

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.incsearch = true -- Makes search act like search in modern browsers
opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom

opt.modelineexpr = true
opt.showcmd = false
opt.showmode = false

-- opt.wildmenu = true
-- opt.wildmode = "longest:full"
-- opt.wildoptions = "pum"
-- Cool floating window popup menu for completion on command line
opt.pumblend = 17

g.mapleader = " "
g.maplocalleader = " "

-- disable default vim stuffs for faster startuptime
g.loaded_2html_plugin = 1
g.loaded_syntax = 1
g.loaded_clipboard_provider = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logiPat = 1
g.loaded_remote_plugins = 1
g.loaded_rrhelper = 1
g.loaded_spellfile_plugin = 1
g.loaded_tarPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_zipPlugin = 1
g.loaded_ftplugin = 1
g.loaded_netrwPlugin = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
