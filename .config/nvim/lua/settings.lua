local g = vim.g
local opt = vim.opt
local o = vim.o

opt.mmp = 20000
opt.shell = "/bin/sh"
o.wildignore = "/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*.git/*"
o.conceallevel = 2
o.shortmess = "aItcF"
o.clipboard = "unnamed,unnamedplus"
o.virtualedit = "block"
o.nrformats = "bin,hex,alpha,octal"
opt.signcolumn = "no"

opt.isfname = opt.isfname - "=" -- fix gf for file_path=path/to/file.txt

o.termguicolors = true

opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }
o.completeopt = "menu,menuone,noselect"

opt.fillchars = opt.fillchars + {
    eob = " ",
    foldclose = "▸",
    foldopen = "▾",
    fold = " ",
    -- vert =  " ",
}

o.wrapmargin = 0

o.lazyredraw = true

g.mapleader = " "
g.maplocalleader = " "

opt.cursorcolumn = false
opt.cursorline = true
opt.timeoutlen = 500

-- fold
opt.foldmethod="syntax"
opt.foldlevel = 99
opt.foldlevelstart = 99
-- -- g.foldmethod = "marker"
g.foldcolumn = 0

opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.updatetime = 1000 -- Make updates happen faster
opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor
opt.laststatus = 3

opt.formatoptions = opt.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    -- - "o" -- O and o, don't continue comments
    -- + "r" -- But do continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- I'm not in gradeschool anymore

opt.inccommand = "split"
opt.swapfile = false -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }
opt.hidden = true -- zepl.vim

opt.joinspaces = false -- Two spaces and grade school, we're done
opt.belloff = "all" -- Just turn the dang bell off

opt.number = false
opt.relativenumber = false

-- Tabs
opt.autoindent = true
opt.cindent = true
-- https://vim.fandom.com/wiki/Restoring_indent_after_typing_hash
opt.cinkeys = opt.cinkeys - "0#"
opt.wrap = false
opt.wrapscan = false

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
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

-- opt.wildmode = opt.wildmode - "list"
-- opt.wildmode = opt.wildmode + { "longest", "full" }

-- opt.list = true
-- opt.listchars:append("space:⋅")
-- opt.listchars:append("eol:↴")

-- disable default vim stuffs for faster startuptime
g.loaded_tutor_mode_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_tarPlugin = 1
g.loaded_remote_plugins = 1
g.loaded_gzip = 1
g.loaded_zipPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_shada_plugin = 1
g.loaded_spellfile_plugin = 1
g.loaded_remote_plugins = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1

g.loaded_matchit = 1
g.loaded_matchparen = 1

-- https://neovim.discourse.group/t/introducing-filetype-lua-and-a-call-for-help/1806#how-do-i-use-it-2
g.do_filetype_lua = 1
g.did_load_filetypes = 0

-- g.loaded_netrw = 1
-- g.loaded_netrwSettings = 1
-- g.loaded_netrwFileHandlers = 1
g.loaded_netrwPlugin = 1

vim.o.statusline = "%f %= %m%r%h%w %-8(%l : %c%) %P"
