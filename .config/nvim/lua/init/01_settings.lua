local vim = vim
local g = vim.g
local opt = vim.opt
local o = vim.o

-- sidebar
o.signcolumn = "yes"

if vim.env.VIM_NONU == "1" then
    o.number = false
    o.relativenumber = false
else 
end

o.number = false
o.relativenumber = false
o.splitkeep = "screen"
o.formatoptions = "jncroql"
o.fillchars = "eob: ,fold: ,foldclose:▸,foldopen:▾,stl: "
o.clipboard = "unnamedplus"
-- o.fencs = "ucs-bom,utf-8,default,euc-kr,latin1"
-- o.fencs = "ucs-bom,utf-8,default,latin1"
-- vim.o.fencs="ucs-bom,utf-8,cp949,euc-kr,default,latin1"

o.cmdheight = 1 -- set to 0 if https://github.com/aserowy/tmux.nvim/issues/105 fixed
o.laststatus = 2

-- o.statusline = "%= %m%r%h%w %l:%c %P "
-- opt.winbar = "%=%l:%c %P %m%f"

o.mmp = 50000
o.shell = "/bin/sh"
opt.wildignore = { "/tmp/*", "*.so", "*.swp", "*.zip", "*.pyc", "*.db", "*.sqlite", "*.git/*" }
o.conceallevel = 3
o.shortmess = "aItcF"
-- opt.clipboard = { "unnamed", "unnamedplus" }
-- o.virtualedit = "block"
opt.nrformats = { "bin", "hex", "alpha", "octal" }

opt.isfname = opt.isfname - "=" -- fix gf for file_path=path/to/file.txt
opt.termguicolors = true

opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }
opt.completeopt = { "menu", "menuone", "noselect" }

opt.wrapmargin = 0
opt.lazyredraw = false -- noice.nvim

opt.cursorcolumn = false
opt.cursorline = true
opt.timeoutlen = 500

-- fold
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 7

opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.updatetime = 500 -- Make updates happen faster
opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor

opt.inccommand = "split"
opt.swapfile = false
opt.shada = { "!", "'1000", "<50", "s10", "h" }
opt.hidden = true -- zepl.vim

opt.joinspaces = false
opt.belloff = "all"


-- Tabs
-- opt.autoindent = true
-- opt.cindent = true

opt.indentkeys = opt.indentkeys + '!^Y'
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

