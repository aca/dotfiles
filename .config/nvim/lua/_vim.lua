-- TODO: migrate to LUA
vim.cmd [[
set shell=/bin/sh

set listchars=tab:\ ──,space:·,nbsp:␣,trail:•,eol:↵,precedes:«,extends:»
set showbreak=⤷\ 

" fold
" set foldlevel=0 " close all folds
set foldlevel=99 " open all folds
" set foldnestmax=3
set foldmethod=marker
set foldcolumn=0
" set cofoldenable
set foldopen+=search
" set foldlevelstart=99

set nolist " don't render special chars(performance)

set wildignore+=/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*.git/*
set conceallevel=2

set wildoptions=pum
set pumblend=30
set breakindent
set breakindentopt=sbr

" https://vimhelp.org/term.txt.html
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors " norcalli/nvim-colorizer.lua need this
" set t_Co=256

" number, toggle with ;n, performance issue
" set ruler
" set number
set relativenumber

set shortmess=aItcF

set mouse=a
set mousemodel=popup

let mapleader      = ' '
let maplocalleader = ' '

" https://jdhao.github.io/2021/06/17/nifty_nvim_techniques_s10/
" fix E447: Can’t find file “file_path=path/to/file.txt” in path.
set isfname-==

set backspace=indent,eol,start
set clipboard^=unnamed,unnamedplus
set diffopt=filler,vertical
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set isfname-==
set lazyredraw
" set redrawtime=20000
" syntax sync minlines=100
" syntax sync maxlines=200
" set synmaxcol=200
" set mmp=2000000    " memory limit
" set modeline
set modelineexpr
set modifiable
set nobackup
set nocompatible
set completeopt=menu,menuone,noselect
set noendofline
set nofixeol
set noshowcmd
set noshowmode
set nostartofline " Keep the cursor on the same column
set noswapfile
set nowrap
set nowrapscan
set nowritebackup
set nrformats+=alpha,hex,octal
" set numberwidth=0
" set showcmd
set signcolumn=yes
set synmaxcol=0
set timeoutlen=400
set ttyfast
set virtualedit=block
" set virtualedit=all
set whichwrap=b,s
" set wildmenu
" set wildmode=full
set wrapmargin=0
set nocursorcolumn
set nocursorline " lag in redraw scrreen

" get rid of fold char
set fillchars=fold:\ 

]]

local opt = vim.opt
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

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

opt.incsearch = true -- Makes search act like search in modern browsers

opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom



-- disable default vim stuffs for faster startuptime
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_remote_plugins    = 1
vim.g.loaded_gzip              = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_shada_plugin      = 1
vim.g.loaded_spellfile_plugin  = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_remote_plugins    = 1
vim.g.loaded_getscript         = 1
vim.g.loaded_getscriptPlugin   = 1
