" vim: foldmethod=marker
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPT(dev){{{
" lua vim.lsp.set_log_level("debug")
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
packadd vim-tmux-navigator

" TODO 
" https://github.com/lewis6991/impatient.nvim
" should be removed when merged to neovim core
" have issues on mac, it freeze sometimes
" lua require'impatient'

" TODO jupyter integration
" https://www.reddit.com/r/neovim/comments/p206ju/magmanvim_interact_with_jupyter_from_neovim/
" https://github.com/dccsillag/magma-nvim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILETYPES {{{
" /usr/local/share/nvim/runtime/filetype.vim

" use treesitter highlight(disable others)
autocmd FileType bash,c,c_sharp,clojure,cmake,comment,commonlisp,cpp,css,dockerfile,fennel,fish,go,gomod,graphql,hcl,html,java,javascript,jsdoc,json,jsonc,lua,vim syntax off

au BufRead,BufNewFile *.rkt,*.rktl  setf scheme
au BufRead,BufNewFile *.fish        setf fish
au BufRead,BufNewFile *.tf,*.tfvars setf terraform
au BufRead,BufNewFile *.hcl         setf hcl

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DEFAULTS {{{
" set shell=/bin/bash

let g:_uname = 'Linux'
if has('mac')
  let g:_uname = 'macOS'
endif

"  ShaDa/viminfo:
"   ' - Maximum number of previously edited files marks
"   < - Maximum number of lines saved for each register
"   @ - Maximum number of items in the input-line history to be
"   s - Maximum size of an item contents in KiB
"   h - Disable the effect of 'hlsearch' when loading the shada
set shada='50,<10,@50,s50
set scrolloff=5
set laststatus=2
set listchars=tab:\ ──,space:·,nbsp:␣,trail:•,eol:↵,precedes:«,extends:»
set showbreak=⤷\ 

" fold
set foldlevel=0 " close all folds
" set foldlevel=99 " open all folds
set foldnestmax=3
set updatetime=1000
set foldmethod=marker
set foldcolumn=0
" set cofoldenable
set foldopen+=search
" set foldlevelstart=99

set nolist " don't render special chars(performance)

set wildignore+=/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*.git/*
set conceallevel=2

set inccommand=split
set wildoptions=pum
set pumblend=30
set splitbelow
set splitright
set hidden " zepl.vim
set breakindent
set breakindentopt=sbr

" https://vimhelp.org/term.txt.html
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors " norcalli/nvim-colorizer.lua need this
" set t_Co=256

" number, toggle with ;n, performance issue
" set ruler
set number
set norelativenumber

" tab
setlocal tabstop=2
setlocal softtabstop=0 " tab
setlocal shiftwidth=2 " indent key
" set noexpandtab " tab to space
set expandtab
" set smarttab

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
set formatoptions+=jcql
set hidden
set hlsearch
set ignorecase
set incsearch
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
set nojoinspaces
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
set signcolumn=no " TODO: fix
set smartcase
set synmaxcol=0
set timeoutlen=400
set ttyfast
set virtualedit=block
" set virtualedit=all
" set visualbell
set whichwrap=b,s
" set wildmenu
" set wildmode=full
set wrapmargin=0
set nocursorcolumn
set nocursorline " lag in redraw scrreen

" get rid of fold char
set fillchars=fold:\ 

" disable default vim stuffs for faster startuptime
" let g:loaded_matchparen        = 1
" let g:loaded_matchit           = 1
" let g:loaded_man               = 1
let g:loaded_logiPat           = 1
let g:loaded_rrhelper          = 1
let g:loaded_tarPlugin         = 1
let g:loaded_remote_plugins    = 1
let g:loaded_gzip              = 1
let g:loaded_zipPlugin         = 1
let g:loaded_2html_plugin      = 1
let g:loaded_shada_plugin      = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_netrw             = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_remote_plugins    = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCMD {{{
" turn syntax off for long yaml
" autocmd FileType yaml if line('$') > 500 | setlocal syntax=OFF | endif

" autocmd TextYankPost * lua vim.highlight.on_yank() 

autocmd QuickFixCmdPost cgetexpr cwindow
autocmd QuickFixCmdPost cgetexpr set ft=qf

autocmd BufWritePre lua vim.lsp.buf.formatting()

" make directory if not exists
autocmd BufWritePre * call s:Mkdir()
function s:Mkdir()
  let dir = expand('%:p:h')
  if dir =~ '://'
    return
  endif
  if !isdirectory(dir)
    call mkdir(dir, 'p')
  endif
endfunction

" restore cursor position on start
au BufReadPost * silent! exe "normal! g`\"" 

" set commentstring to '#' by default
au BufWinEnter,BufAdd * if (&ft =="") | setlocal commentstring=#\ %s | endif
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS {{{
" colorscheme substrata
colorscheme tomorrow-night
" colorscheme monotone
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEMPLATE {{{
autocmd BufNewFile ~/src/zettels/**.md execute "0r! ~/src/configs/dotfiles/.config/nvim/templates/zettels.sh" . ' ' . expand('%:t:r')
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ADDITIONAL {{{
" if filereadable(expand("~/.config/nvim/secrets.vim")) | source $HOME/.config/nvim/secrets.vim | endif
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" force lazy load with timer
function! LazyLoad(_)
  source ~/.config/nvim/lazy.vim
endfunction
autocmd VimEnter * call timer_start(100, "LazyLoad")

" NOTE: should replace init.vim someday
lua require('main')

" lua << EOF
" require("tmux").setup({
"     -- overwrite default configuration
"     -- here, e.g. to enable default bindings
"     copy_sync = {
"         -- enables copy sync and overwrites all register actions to
"         -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
"         enable = false,
"     },
"     navigation = {
"         -- enables default keybindings (C-hjkl) for normal mode
"         enable_default_keybindings = true,
"     },
"     resize = {
"         -- enables default keybindings (A-hjkl) for normal mode
"         enable_default_keybindings = true,
"
"         -- sets resize steps for x axis
"         resize_step_x = 20,
"
"         -- sets resize steps for y axis
"         resize_step_y = 20,
"     }
" })
" EOF

lua require('plug_lazy.tcomment')
