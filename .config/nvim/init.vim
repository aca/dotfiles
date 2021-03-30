" vim:ft=vim et sw=2 foldmethod=marker
" NOTES {{{
"
" TODO(aca)
"   - telescope
"   - treesitter
"   - tabnine
"
" $ vim-startuptime -vimpath nvim | grep Total
" Total Average: 30.272100 msec
" Total Max:     30.534000 msec
" Total Min:     29.962000 msec
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DEFAULTS {{{
" set shada="NONE"
let g:_uname = 'mac' | if has('unix') | let g:_uname = 'linux' | endif

" set guifont=Lotion\ Nerd\ Font\ NF:h28
" let g:neovide_cursor_vfx_mode = "torpedo"
" let g:neovide_cursor_vfx_mode = "pixiedust"

if filereadable("/usr/bin/sh") | set shell=/usr/bin/sh | elseif filereadable("/bin/sh") | set shell=/bin/sh | endif

let &statusline = "%= [%n] %f %<%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}%{&readonly ? '[RO] ' : ''} %-9(%l:%c%)%*%P"

set virtualedit=all


" fold
" set foldlevel=0 " close all folds
set foldlevel=99 " open all folds
set foldnestmax=2
set updatetime=1000
" set foldmethod=indent
set foldcolumn=0
" set cofoldenable
set foldopen+=search
" set foldlevelstart=99
" set foldmarker=[[[,]]]

set nolist " don't render special chars(performance)

set wildignore+=/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*.git/*
set regexpengine=1

set inccommand=split
set wildoptions=pum
set pumblend=30
tnoremap <Esc> <C-\><C-n>

set splitbelow
set splitright

" ctags
set tags=./tags;/

let &showbreak = '↳ '
set breakindent
set breakindentopt=sbr

" https://vimhelp.org/term.txt.html
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors " norcalli/nvim-colorizer.lua need this
" set t_Co=256

" number, toggle with ;n, performance issue
" set ruler
set nonumber
set norelativenumber

" tab
setlocal tabstop=2
setlocal softtabstop=0 " tab
setlocal shiftwidth=2 " indent key
" set noexpandtab " tab to space
set expandtab
" set smarttab

set shortmess=aItcF

" mouse
set mouse=a
set mousemodel=popup

let mapleader      = ' '
let maplocalleader = ' '
set backspace=indent,eol,start
set clipboard^=unnamed,unnamedplus
set diffopt=filler,vertical
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set formatoptions+=j
set formatoptions+=orc
set hidden
set hlsearch
set ignorecase
set incsearch
set isfname-==
set lazyredraw
" set redrawtime=10000
syntax sync minlines=100
syntax sync maxlines=200
let g:vimsyn_minlines=100
let g:vimsyn_maxlines=200
set synmaxcol=200
set mmp=2000000    " memory limit
" set modeline
set modelineexpr
set modifiable
set nobackup
set nocompatible
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
" set numberwidth=3
" set showcmd
set signcolumn=yes
set smartcase
set synmaxcol=0
set timeoutlen=400
set ttyfast
set virtualedit=block
" set visualbell
set whichwrap=b,s
" set wildmenu
" set wildmode=full
set wrapmargin=0
set nocursorcolumn
hi! CursorLine guibg=#011638
set cursorline " lag in redraw scrreen

" get rid of fold char
set fillchars=fold:\ 
" set fillchars=fold:, "
" set fillchars=vert:-

" disable default vim stuffs for faster startuptime
let g:loaded_matchparen        = 1
let g:loaded_matchit           = 1
let g:loaded_logiPat           = 1
let g:loaded_rrhelper          = 1
let g:loaded_tarPlugin         = 1
" let g:loaded_man               = 1
let g:loaded_gzip              = 1
let g:loaded_zipPlugin         = 1
let g:loaded_2html_plugin      = 1
let g:loaded_shada_plugin      = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_remote_plugins    = 1
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PAQ {{{
command PaqInstall call <sid>loadPaq() | :PaqInstall
command PaqClean call <sid>loadPaq() | :PaqClean
command PaqUpdate call <sid>loadPaq() | :PaqUpdate

hi! TabLineSel guibg=#424c55 guifg=#f5edf0 ctermbg=252 ctermfg=239 gui=italic
hi! TabLine ctermbg=065 ctermfg=007 guibg=#4e4e4e guifg=#d0d0d0 gui=italic
hi! TabLineFill guifg=#3a3a3a ctermbg=239 ctermfg=237

function s:loadPaq()
  if empty(glob('~/.local/share/nvim/site/pack/paqs/opt/paq-nvim'))
    silent !git clone https://github.com/savq/paq-nvim.git ~/.local/share/nvim/site/pack/paqs/opt/paq-nvim
  endif
  packadd paq-nvim
lua << EOF
local paq = require'paq-nvim'.paq

paq {'axvr/photon.vim'}
-- paq {'chriskempson/base16-vim'}
paq {'aca/nvim-colors'}

paq {'tyru/columnskip.vim'}
paq {'inkarkat/vim-ReplaceWithRegister', opt=true}
paq {'norcalli/nvim-colorizer.lua', opt=true}
paq {'ap/vim-buftabline', opt=true}
paq {'norcalli/nvim-terminal.lua', opt=true}
paq {'savq/paq-nvim', opt=true}
paq {'aca/funcs.nvim'}
paq {'aca/vidir.nvim'}
paq {'phaazon/hop.nvim', opt=true} -- easymotion
paq {'hrsh7th/vim-vsnip'}
paq {'hrsh7th/nvim-compe'}
paq {'neovim/nvim-lspconfig'}
paq {'glepnir/lspsaga.nvim', opt=true}
paq {'dstein64/nvim-scrollview', opt=true}
paq {'rhysd/clever-f.vim', opt=true}
-- paq {'vifm/vifm.vim', opt=true} -- replaced with floaterm
paq {'voldikss/vim-floaterm', opt=true}
paq {'bronson/vim-visual-star-search', opt=true}
paq {'wsdjeg/vim-fetch'}
paq {'mhinz/vim-startify', opt=true}
paq {'gyim/vim-boxdraw', opt=true}
paq {'arp242/xdg_open.vim', opt=true}
paq {'arecarn/vim-fold-cycle', opt=true}
paq {'RyanMillerC/better-vim-tmux-resizer', opt=true}
paq {'rafcamlet/nvim-luapad', opt=true}
paq {'christoomey/vim-tmux-navigator', opt=true}
paq {'justinmk/vim-dirvish'}
paq {'junegunn/fzf', opt=true}
paq {'aca/fzf.vim', opt=true}
paq {'stefandtw/quickfix-reflector.vim', opt=true}
paq {'lambdalisue/suda.vim', opt=true}

paq {'psliwka/vim-smoothie', opt=true}

paq {'tommcdo/vim-lion', opt=true}
paq {'machakann/vim-sandwich', opt=true}
-- paq {'b3nj5m1n/kommentary', opt=true}
-- paq {'terrortylor/nvim-comment', opt=true}
paq {'tomtom/tcomment_vim', opt=true}

paq {'machakann/vim-swap', opt=true}
paq {'aca/fzf-proj.vim', opt=true}
-- paq {'tmsvg/pear-tree', opt=true}
paq {'windwp/nvim-autopairs'}
paq {'dhruvasagar/vim-table-mode', opt=true}
paq {'sbdchd/neoformat', opt=true}
paq {'metakirby5/codi.vim', opt=true}
paq {'pedrohdz/vim-yaml-folds', opt=true}
paq {'ferrine/md-img-paste.vim', opt=true}
paq {'buoto/gotests-vim', opt=true}
paq {'110y/vim-go-expr-completion', opt=true}
paq {'iamcco/markdown-preview.nvim', opt=true, hook='yarn install --cwd app/' }
paq {'tpope/vim-markdown', opt=true}
paq {'tweekmonster/startuptime.vim', opt=true}
paq {'junegunn/goyo.vim', opt=true}
paq {'monaqa/dial.nvim', opt=true}
-- paq {'tpope/vim-speeddating', opt=true}
paq {'thinca/vim-quickrun', opt=true}
paq {'rhysd/vim-grammarous', opt=true}

-- git
paq {'lambdalisue/gina.vim'}
paq {'mhinz/vim-signify', opt=true}
paq {'rhysd/git-messenger.vim', opt=true}

-- paq {'Rasukarusan/nvim-block-paste', opt=true}

-- paq { 'nvim-lua/plenary.nvim', opt=true}
-- paq { 'lewis6991/gitsigns.nvim', opt=true}

paq {'axvr/zepl.vim'}

-- Language specific
-- https://github.com/sheerun/vim-polyglot
paq {'lervag/vimtex', opt=true}
paq {'aca/nvim-go', opt=true}
paq {'mattn/vim-goaddtags', opt=true}
paq {'aca/pylance.nvim'}
-- paq {'vmchale/just-vim'}
-- paq {'Raku/vim-raku'}
-- paq {'ziglang/zig.vim'}
-- paq {'rust-lang/rust.vim'}
-- paq {'blankname/vim-fish'}
-- paq {'wlangstroth/vim-racket'}
-- paq {'plasticboy/vim-markdown', opt=true}
paq {'rhysd/vim-gfm-syntax', opt=true}
paq {'gabrielelana/vim-markdown', opt=true}
paq {'masukomi/vim-markdown-folding', opt=true}

paq {'xolox/vim-colorscheme-switcher', opt=true}
paq {'xolox/vim-misc', opt=true}

-- paq {'nvim-treesitter/nvim-treesitter', hook=":TSUpdate"}
-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--   highlight = {
--     enable = true,              -- false will disable the whole extension
--     -- disable = { "c", "rust" },  -- list of language that will be disabled
--   },
-- }

EOF
endfunction
" " }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS CONFIG {{{
au BufReadPost *.rkt,*.rktl set filetype=scheme

nmap sj <Plug>(columnskip:nonblank:next)
omap sj <Plug>(columnskip:nonblank:next)
xmap sj <Plug>(columnskip:nonblank:next)
nmap sk <Plug>(columnskip:nonblank:prev)
omap sk <Plug>(columnskip:nonblank:prev)
xmap sk <Plug>(columnskip:nonblank:prev)

" [count]["x]gr{motion}   Replace {motion} text with the contents of register x.
"                         Especially when using the unnamed register, this is
"                         quicker than "_d{motion}P or "_c{motion}<C-R>"
" [count]["x]grr          Replace [count] lines with the contents of register x.
"                         To replace from the cursor position to the end of the
"                         line use ["x]gr$
" {Visual}["x]gr          Replace the selection with the contents of register x.
nmap <silent>gr :packadd vim-ReplaceWithRegister \| execute "normal gr"<cr>
nmap <silent>grr :packadd vim-ReplaceWithRegister \| execute "normal grr"<cr>
xmap <silent>gr :packadd vim-ReplaceWithRegister \| execute "normal gr"<cr>

let g:buftabline_show = 2
let g:buftabline_numbers = 2
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

command! Colorizer packadd nvim-colorizer.lua | :ColorizerToggle

" silent! nmap  <silent><C-A>     :packadd vim-speeddating \| :execute "normal \<c-a>"<cr>
" silent! nmap  <silent><C-X>     :packadd vim-speeddating \| :execute "normal \<c-x>"<cr>
" nmap d<C-A>     :packadd vim-speeddating \| <c-v><c-a>
" nmap d<C-X>     :packadd vim-speeddating \| <c-v><c-a>
" xmap  <C-A>     <Plug>SpeedDatingUp
" xmap  <C-X>     <Plug>SpeedDatingDown
"
nmap gx :packadd xdg_open.vim \| execute "normal gx"<cr>
xmap gx :packadd xdg_open.vim \| execute "normal gx"<cr>

let g:quickrun_no_default_key_mappings=1
let g:quickrun_config = {
      \'*': {
      \'outputter/buffer/split': ':10split'}}
nnoremap <silent><Leader>qr :packadd vim-quickrun \| :execute "normal \<plug>(quickrun)"<cr>
vnoremap <silent><Leader>qr <esc>:packadd vim-quickrun \| :execute "normal gv \<plug>(quickrun)"<cr>

" vim-lion
nmap <silent>gl :packadd vim-lion<cr>gl
nmap <silent>gL :packadd vim-lion<cr>gL
vmap <silent>gl <esc>:packadd vim-lion<cr>gvgl
vmap <silent>gL <esc>:packadd vim-lion<cr>gvgL

command! CODI packadd codi.vim | :Codi
command! Grammar packadd vim-grammarous | :GrammarousCheck

autocmd! FileType rust packadd rust.vim
autocmd! FileType go packadd vim-goaddtags | packadd nvim-go | packadd gotests-vim| setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
autocmd! FileType yaml packadd vim-yaml-folds
" autocmd! FileType markdown packadd vim-markdown | packadd vim-markdown-folding | packadd md-img-paste.vim | packadd vim-table-mode
autocmd! FileType markdown packadd ivm-gfm-syntax| packadd vim-markdown-folding | packadd md-img-paste.vim | packadd vim-table-mode
autocmd! FileType qf call <SID>setup_quickfix_reflector()

function! s:setup_quickfix_reflector()
  if !exists('g:loaded_quickfix_reflector')
    packadd quickfix-reflector.vim
  endif
  let g:loaded_quickfix_reflector=1
endfunction

" iamcco/markdown-preview.nvim
let g:mkdp_refresh_slow = 1
" let g:mkdp_markdown_css = '/home/rok/src/github.com/yrgoldteeth/darkdowncss/darkdown.css'
let g:mkdp_markdown_css = expand('~/src/github.com/edwardtufte/tufte-css/tufte.css')
" let g:mkdp_highlight_css = expand('~/src/github.com/edwardtufte/tufte-css/tufte.css')

" let g:mkdp_markdown_css = expand('~/src/github.com/jez/tufte-pandoc-css/pandoc-solarized.css')
let g:mkdp_auto_close = 0
let g:mkdp_command_for_global = 1
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'disable_filename': 1
    \ }

" ferrine/md-img-paste.vim
let g:mdip_imgdir = '.image'
nmap <leader>ip :call mdip#MarkdownClipboardImage()<CR>

" lambdalisue/gina.vim
cnoreabbrev Git Gina
" cnoreabbrev git Gina
command! Gbrowse execute "normal! vv" | :'<,'>Gina browse --exact :
command! Glog :Gina log -- %:p

" junegunn/goyo.vim
let g:goyo_width='100'
let g:goyo_height='100%'
let g:goyo_linenr=0
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

function! s:goyo_enter()
  " execute "normal! :ScrollViewEnable"
endfunction

function! s:goyo_leave()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" mhinz/vim-signify
let g:signify_sign_show_text = 1
let g:signify_sign_show_count = 0
" let g:signify_disable_by_default = 1
highlight! SignifySignAdd    ctermfg=green  guifg=#696969 cterm=NONE guibg=NONE
highlight! SignifySignDelete ctermfg=red    guifg=#696969 cterm=NONE guibg=NONE
highlight! SignifySignChange ctermfg=yellow guifg=#696969 cterm=NONE guibg=NONE
nmap <silent> ]h <plug>(signify-next-hunk)
nmap <silent> [h <plug>(signify-prev-hunk)
autocmd CursorHold * packadd vim-signify | :SignifyEnable

" tommcdo/vim-lion
" jonasw234/vim-lion " https://github.com/tommcdo/vim-lion/pull/28/files
let g:lion_squeeze_spaces = 1

" vim-sandwich
" let g:loaded_textobj_sandwich = 1
" let g:sandwich_no_default_key_mappings = 1
" let g:operator_sandwich_no_default_key_mappings = 1
" let g:textobj_sandwich_no_default_key_mappings = 1
" nmap ds <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
" nmap dss <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
" nmap cs <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
" nmap css <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
nmap <silent>ds  :call <sid>setup_sandwich()<cr>sd
nmap <silent>dss :call <sid>setup_sandwich()<cr>sdb
nmap <silent>cs  :call <sid>setup_sandwich()<cr>sr
nmap <silent>css :call <sid>setup_sandwich()<cr>srb
xmap <silent>S   <esc>:call <sid>setup_sandwich()<cr>gvsa

let g:wr3#ee =3 

function s:setup_sandwich() 
  if !exists('g:loaded_sandwich')
    packadd vim-sandwich
    let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
    let g:sandwich#recipes += [
          \   {
          \     'buns'    : ['print(', ')'],
          \     'filetype': ['python'],
          \     'nesting' : 0,
          \     'input'   : ['p', 'P'],
          \   },
          \   {
          \     'buns'    : ['fmt.Printf(', ')'],
          \     'filetype': ['go'],
          \     'nesting' : 0,
          \     'input'   : ['p', 'P'],
          \   },
          \   {
          \     'buns'    : ['log.Print(', ')'],
          \     'filetype': ['go'],
          \     'nesting' : 0,
          \     'input'   : ['l', 'L'],
          \   },
          \   {
          \     'buns'    : ['[](', ')'],
          \     'filetype': ['markdown'],
          \     'nesting' : 0,
          \     'input'   : ['l','L'],
          \   },
          \   {
          \     'buns'    : ['console.log(', ')'],
          \     'filetype': ['javascript','typescript'],
          \     'nesting' : 0,
          \     'input'   : ['p', 'P'],
          \   },
          \   {
          \     'buns'    : ['print(', ')'],
          \     'filetype': ['lua','luapad'],
          \     'nesting' : 0,
          \     'input'   : ['p', 'P'],
          \   },
          \ ]
  endif
endfunction

" plasticboy/vim-markdown
" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_override_foldtext = 0
" let g:vim_markdown_no_default_key_mappings = 1
" let g:vim_markdown_toc_autofit = 0

" https://github.com/gabrielelana/vim-markdown
let g:markdown_enable_folding = 0
let g:markdown_include_jekyll_support = 0 
let g:markdown_enable_mappings = 0
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_input_abbreviations = 0
let g:markdown_enable_conceal = 1 


" sbdchd/neoformat
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_lua = ['luafmt']
let g:neoformat_async = 1

" monaqa/dial.nvim
function! s:setup_dial()
  if !exists('g:loaded_dial')
    packadd dial.nvim
    lua << EOF
local dial = require("dial")
dial.config.searchlist.normal = {
    "number#decimal",
    "number#hex",
    "number#binary",
    "number#decimal#fixed#zero",
    "number#decimal#fixed#space",
    "date#[%Y/%m/%d]",
    "markup#markdown#header",
    "char#alph#small#str",
}
EOF
  endif
endfunction

nmap <silent><C-a>  :call <sid>setup_dial() \| :execute "normal \<Plug>(dial-increment)"<cr>
nmap <silent><C-x>  :call <sid>setup_dial() \| :execute "normal \<Plug>(dial-decrement)"<cr>
vmap <silent><C-a>  :call <sid>setup_dial() \| :execute "normal gv \<Plug>(dial-increment)"<cr>
vmap <silent><C-x>  :call <sid>setup_dial() \| :execute "normal gv \<Plug>(dial-decrement)"<cr>
vmap <silent>g<C-a> :call <sid>setup_dial() \| :execute "normal gv \<Plug>(dial-increment-additional)"<cr>
vmap <silent>g<C-x> :call <sid>setup_dial() \| :execute "normal gv \<Plug>(dial-decrement-additional)"<cr>


" machakann/vim-swap
let g:swap_no_default_key_mappings = 1
nnoremap <silent>g< :packadd vim-swap \|: execute "normal \<Plug>(swap-prev)"<cr>
nnoremap <silent>g> :packadd vim-swap \|: execute "normal \<Plug>(swap-next)"<cr>

" windwp/nvim-autopairs
silent! lua require('nvim-autopairs').setup()

" nmap <silent>- :packadd vim-dirvish \| :execute "normal \<Plug>(dirvish_up)"<cr>
" nmap <silent>- :packadd vim-dirvish \| :execute "normal \<Plug>(dirvish_up)"<cr>
" command! -nargs=? -complete=dir Explore Dirvish <args>
" command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
" command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" iamcco/markdown-preview.nvim
" command! MarkdownPreview execute ":packadd markdown-preview.nvim | :call mkdp#util#open_preview_page()"
" command! MarkdownPreview packadd markdown-preview.nvim | call mkdp#util#open_preview_page()"
nnoremap <silent><leader>md :packadd markdown-preview.nvim \| :call mkdp#util#open_preview_page()<cr>
" b3nj5m1n/kommentary
" nnoremap <silent> gcc  :packadd kommentary \| :execute "normal \<plug>kommentary_line_default"<cr>
" vnoremap <silent> gc <esc>:packadd kommentary \| :execute "normal gv \<plug>kommentary_visual_default"<cr>
" nnoremap <silent> gc  :packadd kommentary \| :execute "normal \<plug>kommentary_motion_default"<cr>

" terrortylor/nvim-comment
" packadd nvim-comment
" lua require('nvim_comment').setup()

" tomtom/tcomment_vim
nmap <silent>gcc :packadd tcomment_vim \| :exe "normal gcc"<cr>
vmap <silent>gc <esc>:packadd tcomment_vim \| :exe "normal gv gc"<cr>

" vim-smoothie
nmap <silent><c-d> :packadd vim-smoothie \| :execute "normal \<Plug>(SmoothieDownwards)"<cr>
nmap <silent><c-u> :packadd vim-smoothie \| :execute "normal \<Plug>(SmoothieUpwards)"<cr>

" clever-f
nmap <silent>f :packadd clever-f.vim \| :call feedkeys("f")<cr>

" phaazon/hop.nvim
nmap <silent><Leader>w :packadd hop.nvim \| :HopWord<cr>

" aca/funcs.nvim
xmap s :SortVis<CR>
nnoremap yp :YankPath<cr>

" hrsh7th/vim-vsnip
" let g:vsnip_filetypes = {}
" let g:vsnip_filetypes.sh = ['bash']
" let g:vsnip_filetypes.javascriptreact = ['javascript']
" let g:vsnip_filetypes.typescriptreact = ['typescript']
let g:vsnip_snippet_dir = expand('~/.config/nvim/snippets')

" hrsh7th/nvim-compe
let g:loaded_compe_ultisnips = 1
let g:loaded_compe_path = 1
let g:loaded_compe_snippets_nvim = 1
let g:loaded_compe_omni = 1
let g:loaded_compe_vim_lsc = 1
let g:loaded_compe_lamp = 1
let g:loaded_compe_spell = 1
let g:loaded_compe_tags = 1
let g:loaded_compe_treesitter = 1
let g:loaded_compe_emoji = 1
let g:loaded_compe_nvim_lua = 1
let g:loaded_compe_calc = 1

" dstein64/nvim-scrollview
" autocmd CursorHold * packadd nvim-scrollview | :ScrollViewEnable
let g:scrollview_winblend=20
let g:scrollview_base='right'

" arecarn/vim-fold-cycle
let g:fold_cycle_default_mapping = 0 "disable default mappings
nmap <silent><cr> :packadd vim-fold-cycle \|:execute "normal \<Plug>(fold-cycle-toggle-all)"<cr>

" tmux
nnoremap <silent> <c-h> :packadd vim-tmux-navigator \| :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :packadd vim-tmux-navigator \| :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :packadd vim-tmux-navigator \| :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :packadd vim-tmux-navigator \| :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :packadd vim-tmux-navigator \| :TmuxNavigatePrevious<cr>

let g:tmux_resizer_no_mappings = 1
nnoremap <silent> <m-h> :packadd better-vim-tmux-resizer \| :TmuxResizeLeft<cr>
nnoremap <silent> <m-j> :packadd better-vim-tmux-resizer \| :TmuxResizeDown<cr>
nnoremap <silent> <m-k> :packadd better-vim-tmux-resizer \| :TmuxResizeUp<cr>
nnoremap <silent> <m-l> :packadd better-vim-tmux-resizer \| :TmuxResizeRight<cr>

" junegunn/fzf
set rtp+=/usr/local/bin
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

" lambdalisue/suda.vim
command! SudoWrite packadd suda.vim | :SudaWrite
command! SudoRead packadd suda.vim | :SudaRead

command! GitMessenger packadd git-messenger.vim | :GitMessenger
nnoremap gm :GitMessenger<cr>

function s:setup_visual_star_search() 
  if !exists('g:loaded_visual_star_search')
  endif
  let g:loaded_visual_star_search = 1
  packadd vim-visual-star-search
endfunction

" nmap <silent>gl :packadd vim-lion<cr>gl
" nmap <silent>gL :packadd vim-lion<cr>gL
" vmap <silent>gl <esc>:packadd vim-lion<cr>gvgl
" vmap <silent>gL <esc>:packadd vim-lion<cr>gvgL

" bronson/vim-visual-star-search
" xmap <silent>* :<c-u>packadd vim-visual-star-search<cr> \| :execute("normal gv \*")<cr>
" xmap <silent># :<c-u>packadd vim-visual-star-search<cr> \| :execute("normal gv \#")<cr>
" xmap <silent>* :<c-u>call <sid>setup_visual_star_search<cr> \| :execute("normal gv \*")<cr>
" xmap <silent># :<c-u>call <sid>setup_visual_star_search<cr> \| :execute("normal gv \#")<cr>
xmap <silent>* <esc>:<sid>setup_visual_star_search<cr>gv*
xmap <silent># <esc>:<sid>setup_visual_star_search<cr>gv#
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NVIM-LSP {{{
lua << EOF
require '_lsp'

require'compe'.setup {
  enabled = true;
  debug = false;
  preselect = 'disable';
  min_length = 1;
  -- -- throttle_time = ... number ...;
  -- -- source_timeout = ... number ...;
  -- -- incomplete_delay = ... number ...;
  allow_prefix_unmatch = true;
  --
  source = {
    path = true;
    buffer = true;
    vsnip = true;
    nvim_lsp = true;
    treesitter= true;
    nvim_treesitter = true;
    calc = true;
    -- nvim_lua = { ... overwrite source configuration ... };
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" set completeopt=menuone,noinsert,noselect
set completeopt=menu,menuone,noselect

nnoremap <silent> gD          <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap gd :vsplit<bar>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> K           :LspSagaHoverDoc<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gt          <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> rr          <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> gr          :LspSagaFinder<CR>

" lua require'lspsaga.diagnostic'.show_line_diagnostics()
" nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
" inoremap <silent> <c-k> <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

nnoremap <silent> pd          <cmd>lua vim.lsp.buf.peek_definition()<CR>
nnoremap <silent> g0          <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW          <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>a   <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <silent> <leader>a   <cmd>lua vim.lsp.buf.range_code_action()<CR>
nnoremap <silent> ]d          <cmd>lua vim.lsp.diagnostic.goto_next({wrap = false})<CR>
nnoremap <silent> [d          <cmd>lua vim.lsp.diagnostic.goto_prev({wrap = false})<CR>
nnoremap <silent> <leader>d   <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <leader>dl           <cmd>lua require'diagnostic.util'.show_line_diagnostics()<CR>
inoremap <silent><c-j> <c-o>:call vsnip#expand()<cr>
inoremap <silent><expr> <C-e> compe#complete()
inoremap <silent><expr> <CR> compe#confirm('<CR>')


" imap <expr><TAB>
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ compe#complete()
"
" imap <expr><silent><S-Tab>
"       \ vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' :
"       \ pumvisible() ? "\<C-p>" :
"       \ "\<S-Tab>"
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCMD {{{
augroup _autocmd_
  au!

  " Autoclose terminal without prompt
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
  " Ignore various filetypes as those will close terminal automatically
  " Ignore fzf, ranger, coc
  autocmd TermClose term://*
        \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") |
        \   call nvim_input('<CR>')  |
        \ endif

  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)

  " Plug 'pbrisbin/vim-mkdir'
  function s:Mkdir()
    let dir = expand('%:p:h')
    if dir =~ '://'
      return
    endif
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endfunction
  autocmd BufWritePre * call s:Mkdir()

  autocmd BufAdd * packadd vim-buftabline | :call buftabline#update(0)
  " autocmd CursorHold,CursorHoldI *.go,*.py silent lua require('lspsaga.signaturehelp').signature_help()

  " au! BufNewFile,BufRead *.json set syntax=disable
  au! BufNewFile,BufRead *.json set foldmethod=indent
  au! FileType markdown setlocal autoindent | setlocal tabstop=4 | setlocal shiftwidth=4 | setlocal textwidth=82 | setlocal comments=fb:>,fb:*,fb:+,fb:-
  " au! FileType yaml setlocal tabstop=2 | setlocal softtabstop=0 | setlocal shiftwidth=2

  " au BufNewFile,BufRead justfile setf make

  " https://github.com/vim/vim/blob/master/runtime/defaults.vim
  au BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
  
  " comment for no file
  au BufWinEnter,BufAdd * if (&ft =="") | setlocal commentstring=#\ %s | endif

  " https://stackoverflow.com/questions/630884/opening-vim-help-in-a-vertical-split-window
  " au FileType help wincmd L

  au FileType go,json,sh,fish,python set foldmethod=syntax

  " jsonc
  au FileType json setlocal commentstring=//\ %s

  " if there's no other window but quickfix close it
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif

  " source a visual range
  autocmd Filetype vim vmap so y:@"<CR>

  " formatter
  " au FileType sh nnoremap <leader>pp :Shfmt<cr>
  " au FileType typescript,javascript,jsx,tsx nnoremap <leader>pp <cmd>lua vim.lsp.buf.formatting()<CR>
  " au FileType c ClangFormatAutoEnable
  autocmd FileType go,typescript,javascript.jsx,tsx,typescript.tsx nnoremap <leader>pp <cmd>lua vim.lsp.buf.formatting()<CR>
  " autocmd FileType go nnoremap <buffer> <leader>ppp :Goimports<cr>
  " autocmd FileType * if index(['go', 'javascript', 'typescript', 'javascript.jsx', 'typescript.tsx'], &ft) < 0 | nnoremap <buffer> <Leader>pp :packadd neoformat \| :Neoformat<cr> | endif

augroup END
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYMAP {{{
" https://vim.fandom.com/wiki/Unused_keys

" visual block increment
vnoremap <C-a> g<C-a>
vnoremap <C-x> g<C-x>
vnoremap g<C-a> <C-a>
vnoremap g<C-x> <C-x>
nnoremap <c-g> 2<c-g>

" imap <C-d> # <ESC>:r! date "+\%H:\%M \%a \%m/\%d/\%Y"<CR>kJ$a

" mistakes
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev q1 q!
cnoreabbrev E e
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
cnoreabbrev Qa qa
cnoreabbrev QA qa
cnoreabbrev Vs vs
cnoreabbrev VS vs

" repeat last command
" noremap <leader>re @:<CR>

" qq to record, Q to replay
nnoremap Q @q
vnoremap Q :norm @q<cr>

" nnoremap J gJ

" navigate errors
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
nnoremap ]w <c-w>w
nnoremap [w <c-w>W
nnoremap ]f :NextFile<cr>
nnoremap [f :PrevFile<cr>
nnoremap [c :packadd vim-misc \| packadd vim-colorscheme-switcher \| :NextColorScheme<cr>
nnoremap ]c :packadd vim-misc \| packadd vim-colorscheme-switcher \| :PrevColorScheme<cr>

nnoremap <leader>c :cclose<bar>lclose<cr>
nnoremap <leader>o :only<cr>
nnoremap <leader>x :bd!<cr>

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
command! Fish terminal fish
nnoremap <leader>s :botright 10sp<bar>  :Fish<cr>i
" noremap <Leader>h :vs<bar>:terminal fish<CR>i
" noremap <Leader>v :sp<bar>:terminal fish<CR>i

" Set working directory(pwd) to location where current file is located
" nnoremap <leader>. :lcd %:p:h<CR>

" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Clean search (highlight)
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>

" vv, instead of V (which includes new line) + copy
nnoremap vv g^vg_"+ygv

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" command! -nargs=* T split | terminal <args>
" command! -nargs=* VT vsplit | terminal <args>
"
function s:close()
  if len(getbufinfo({'buflisted':1})) > 1
    " :q
    bd!
  else
    exit
  endif
endfunction
inoremap <silent><C-Q>     <esc>:call <sid>close()<cr>
nnoremap <silent><C-Q>     :call <sid>close()<cr>
vnoremap <silent><C-Q>     <esc>:call <sid>close()<cr>

" Save
inoremap <C-s>     <esc>:update<cr>
nnoremap <C-s>     :update<cr>
" nnoremap <leader>s :update<cr>
" nnoremap <leader>w :update<cr>
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TOGGLE {{{
" let g:_colorscheme_mono='bruin'
" function! ColorToggle()
"   if g:colors_name != g:_colorscheme_mono
"     execute "colorscheme " . g:_colorscheme_mono
"   else
"     execute "colorscheme " . g:_colorscheme
"   endif
" endfunction
" nnoremap ;c :call ColorToggle()<cr>

let g:floaterm_opener="edit"
" command Vifm :packadd vim-floaterm | :FloatermNew --height=0.9 --width=0.9 --title=vifm vifm -c ':vs |:tree! | :view! | set nodotfiles' --select README.md
" command Vifm :packadd vim-floaterm | :FloatermNew --height=0.9 --width=0.9 --title=vifm vifm -c ':vs |:tree! | :view! | set nodotfiles' 
" " command Vifm :packadd vim-floaterm | :FloatermNew --height=0.9 --width=0.9 --title=vifm vifm --select %:p
command Vifm :packadd vim-floaterm | :call s:vifm()

function s:vifm()
  if expand('%:p') != "" 
    FloatermNew --height=0.9 --width=0.9 --title=vifm vifm --select %:p
  else
    FloatermNew --height=0.9 --width=0.9 --title=vifm vifm -c ':vs |:tree! | :view! | set nodotfiles'
  end
endfunction

nnoremap <expr>   ;f &foldlevel ? 'zM' :'zR'
nnoremap <silent> ;w :set wrap!<CR>
nnoremap <silent> ;t :Vifm<CR>
" nnoremap <silent> <leader>ff :Vifm<CR>
nnoremap <silent> ;n :set number! \| set relativenumber!<CR>
nnoremap <silent> ;z :packadd goyo.vim \| :silent! Goyo<CR>
nnoremap <silent> ;s
             \ : if exists("syntax_on") <BAR>
             \    syntax off <BAR>
             \ else <BAR>
             \    syntax enable <BAR>
             \ endif<CR>
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF {{{
" https://github.com/junegunn/fzf/issues/1143
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
au FileType fzf tnoremap <buffer> <Esc> <c-c>
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS = '--inline-info --color "gutter:-1"  '
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let g:fzf_buffers_jump = 1 " [Buffers] Jump to the existing window if possible

" Rg without filename
command! -bang -nargs=* Rgg call fzf#vim#grep('rg --column --line-number --color=always --no-heading --line-number --smart-case -- 2>/dev/null '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4.. ', 'window': { 'width': 0.9, 'height': 0.9 }}), 0)

" fzf mark with preview
function! s:fzfmarks() abort
  return call('fzf#vim#with_preview', [{'options': '--preview-window +{2}-/2', 'placeholder': '$([ -r $(echo {4} | sed "s#^~#$HOME#") ] && echo {4} || echo ' . fzf#shellescape(expand('%')) . '):{2}'}, 'up:50%', 'ctrl-/'])
endfunction
command! -bar -bang FZFMarks execute ':packadd fzf | :packadd fzf.vim | call fzf#vim#marks(s:fzfmarks(), 0)'

nnoremap <silent><leader>rg           :packadd fzf \|   :packadd fzf.vim \|   :Rgg<cr>
nnoremap <silent><leader><leader>rg   :packadd fzf \|   :packadd fzf.vim \|   :Rg<cr>
nnoremap <silent><Leader>fw           :packadd fzf \|   :packadd fzf.vim \|   :Rg <C-R><C-W><CR>
nnoremap <silent><Leader>fW           g :packadd fzf \| :packadd fzf.vim \|   :Rg <C-R><C-A><CR>
vnoremap <silent><Leader>fw           y :packadd fzf \| :packadd fzf.vim \|   :Rg <C-R>"<CR>
nnoremap <silent><leader>fl           :packadd fzf \|   :packadd fzf.vim \|   :BLines<cr>
nnoremap <silent><leader>ff           :packadd fzf \|   :packadd fzf.vim \|   :Files<cr>
nnoremap <silent><leader>fh           :packadd fzf \|   :packadd fzf.vim \|   :History<CR>
nnoremap <silent><leader>'            :packadd fzf \|   :packadd fzf.vim \|   :FZFMarks<cr>
nnoremap <silent><leader>b            :packadd fzf \|   :packadd fzf.vim \|   :Buffers<cr>
nnoremap <silent><leader>fc           :packadd fzf \|   :packadd fzf.vim \|   :Colors<cr>
let g:fzf#proj#project_dir="$HOME/src"
let g:fzf#proj#max_proj_depth=5
nnoremap <silent><leader>fp           :packadd fzf \|   :packadd fzf.vim \|   :packadd fzf-proj.vim  \|  :Projects<cr>
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HIGHLIGHT {{{
" colorscheme monokai_pro
" colorscheme codedark
" colorscheme vscode-dark
colorscheme tomorrow-night
" colorscheme base16-tomorrow-night-eighties
" colorscheme base16-tomorrow-night
" colorscheme tomorrow-night
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HOST SPECIFIC {{{
silent! source $HOME/.config/nvim/$HOSTNAME.vim
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STARTIFY {{{
if !argc() && line2byte('$') == -1 
  function! s:gitModified()
      let files = systemlist('git ls-files -m 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
  endfunction

  " same as above, but show untracked files, honouring .gitignore
  function! s:gitUntracked()
      let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
  endfunction

  let g:startify_custom_header = ''

  let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
          \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]
  packadd vim-startify
end
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UTILS {{{
command! NeuronUpdate silent! exe '1,5s/^date: 2.*/date: '. strftime("%Y-%m-%dT%H:%M")

" gF that works with ~/.config/nvim/init.vim:3^2 (cursor at ^)
function s:gF()
  try 
    execute "normal! gF"
  catch 
    try 
      execute "normal! bgF"
    catch
      execute "normal! bbgF"
    endtry
  endtry
endfunction
nnoremap <silent> gf :call <sid>gF()<cr>


function GetHighlight()
  hi Normal
  hi Bold
  hi Debug
  hi Directory
  hi Error
  hi ErrorMsg
  hi Exception
  hi FoldColumn
  hi Folded
  hi IncSearch
  hi Italic
  hi Macro
  hi MatchParen
  hi ModeMsg
  hi MoreMsg
  hi Question
  hi Search
  hi Substitute
  hi SpecialKey
  hi TooLong
  hi Underlined
  hi Visual
  hi VisualNOS
  hi WarningMsg
  hi WildMenu
  hi Title
  hi Conceal
  hi Cursor
  hi NonText
  hi LineNr
  hi SignColumn
  hi StatusLine
  hi StatusLineNC
  hi VertSplit
  hi ColorColumn
  hi CursorColumn
  hi CursorLine
  hi CursorLineNr
  hi QuickFixLine
  hi PMenu
  hi PMenuSel
  hi TabLine
  hi TabLineFill
  hi TabLineSel
  hi Boolean
  hi Character
  hi Comment
  hi Conditional
  hi Constant
  hi Define
  hi Delimiter
  hi Float
  hi Function
  hi Identifier
  hi Include
  hi Keyword
  hi Label
  hi Number
  hi Operator
  hi PreProc
  hi Repeat
  hi Special
  hi SpecialChar
  hi Statement
  hi StorageClass
  hi String
  hi Structure
  hi Tag
  hi Todo
  hi Type
  hi Typedef
endfunction

" https://vim.fandom.com/wiki/Capture_ex_command_output
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    " use "new" instead of "tabnew" below if you prefer split windows instead of tabs
    tabnew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)


" }}}