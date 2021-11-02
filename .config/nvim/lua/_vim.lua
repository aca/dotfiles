-- TODO: migrate to LUA
vim.cmd([[
set shell=/bin/sh

set guifont=SauceCodePro\ Nerd\ Font

set wildignore+=/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*.git/*
set conceallevel=2

" https://vimhelp.org/term.txt.html
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors " norcalli/nvim-colorizer.lua need this
" set t_Co=256

set shortmess=aItcF

" https://jdhao.github.io/2021/06/17/nifty_nvim_techniques_s10/
" fix E447: Can’t find file “file_path=path/to/file.txt” in path.
set isfname-==

set backspace=indent,eol,start
set clipboard^=unnamed,unnamedplus
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set isfname-==
" set redrawtime=20000
" syntax sync minlines=100
" syntax sync maxlines=200
" set synmaxcol=200
" set mmp=2000000    " memory limit
" set modeline
set nrformats+=alpha,hex,octal
" set numberwidth=0
set signcolumn=yes
set synmaxcol=0
set virtualedit=block
" set virtualedit=all
set whichwrap=b,s

]])

local opt = vim.opt
local g = vim.g

opt.diffopt='filler,vertical'
opt.completeopt='menu,menuone,noselect'

opt.fillchars='fold: ,vert:│,eob: ,msgsep:‾'
opt.wrapmargin=0

opt.lazyredraw = true

g.mapleader      = ' '
g.maplocalleader = ' '

g.cursorcolumn = false
g.cursorline = true

g.timeoutlen=400

-- fold
g.foldlevel=99
g.foldlevelstart=99
g.foldmethod="marker"
g.foldcolumn=0


opt.cursorline = true -- Highlight the current line
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.updatetime = 1000 -- Make updates happen faster
opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor
opt.laststatus = 2

opt.formatoptions = opt.formatoptions
	- "a" -- Auto formatting is BAD.
	- "t" -- Don't auto format my code. I got linters for that.
	+ "c" -- In general, I like it when comments respect textwidth
	+ "q" -- Allow formatting comments w/ gq
	- "o" -- O and o, don't continue comments
	+ "r" -- But do continue when pressing enter.
	+ "n" -- Indent past the formatlistpat, not underneath it.
	+ "j" -- Auto-remove comments if possible.
	- "2" -- I'm not in gradeschool anymore

opt.inccommand = "split"
opt.swapfile = false -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }
opt.hidden = true -- zepl.vim

opt.joinspaces = false -- Two spaces and grade school, we're done
opt.belloff = "all" -- Just turn the dang bell off

-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = true
opt.wrapscan = false

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

opt.incsearch = true -- Makes search act like search in modern browsers

opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom

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

-- https://github.com/nathom/filetype.nvim
g.did_load_filetypes = 1

-- g.loaded_netrw = 1
-- g.loaded_netrwSettings = 1
-- g.loaded_netrwFileHandlers = 1
-- g.loaded_netrwPlugin = 1

vim.opt.modelineexpr = true
vim.opt.showcmd = false
vim.opt.showmode = false

opt.wildmode = { "longest", "list", "full" }
-- Cool floating window popup menu for completion on command line
opt.pumblend = 17

opt.wildmode = opt.wildmode - "list"
opt.wildmode = opt.wildmode + { "longest", "full" }
