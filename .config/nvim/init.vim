" vim:ft=vim et sw=2 foldmethod=marker

" lua vim.lsp.set_log_level("debug")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PERF {{{
" vim-startuptime -vimpath nvim | head -n 20
" Extra options: []
" Measured: 10 times
"
" Total Average: 25.003300 msec
" Total Max:     25.448000 msec
" Total Min:     24.536000 msec
"
"   AVERAGE       MAX       MIN
" ------------------------------
" 12.028100 12.362000 11.701000: /home/rok/.config/nvim/init.vim
"  5.218000  5.446000  5.104000: /usr/share/nvim/runtime/filetype.vim
"  1.360600  1.387000  1.341000: reading ShaDa
"  1.019000  1.066000  1.000000: loading plugins
"  0.705500  0.844000  0.675000: loading packages
"  0.524500  0.561000  0.503000: loading after plugins
"  0.521900  0.535000  0.506000: /usr/share/nvim/runtime/syntax/syntax.vim
"  0.472300  0.499000  0.447000: /home/rok/.local/share/nvim/site/pack/paqs/start/nvim-compe/after/plugin/compe_buffer.vim
"  0.418800  0.431000  0.407000: /usr/share/nvim/runtime/syntax/synload.vim
"  0.402300  0.411000  0.393000: /home/rok/.local/share/nvim/site/pack/paqs/start/nvim-compe/after/plugin/compe_nvim_lsp.vim
"  0.380600  0.544000  0.237000: /home/rok/.local/share/nvim/site/pack/paqs/start/nvim-colors/colors/tomorrow-night.vim
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DEFAULTS {{{
set shada='100,f1,<100
let g:_uname = 'macOS' | if has('unix') | let g:_uname = 'Linux' | endif

" if filereadable("/usr/bin/sh") | set shell=/usr/bin/sh | elseif filereadable("/bin/sh") | set shell=/bin/sh | endif
" set shell=/bin/sh

let &statusline = "%= [%n] %f %<%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}%{&readonly ? '[RO] ' : ''} %-9(%l:%c%)%*%P"

set virtualedit=all
set laststatus=0

" fold
" set foldlevel=0 " close all folds
set foldlevel=99 " open all folds
set foldnestmax=3
set updatetime=1000
" set foldmethod=indent
set foldcolumn=0
" set cofoldenable
set foldopen+=search
" set foldlevelstart=99
" set foldmarker=[[[,]]]

set nolist " don't render special chars(performance)

set wildignore+=/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*.git/*
" set regexpengine=1

set inccommand=split
set wildoptions=pum
set pumblend=30
tnoremap <Esc> <C-\><C-n>

set splitbelow
set splitright


" zepl.vim
set hidden

" ctags
set tags=./tags;/

let &showbreak = '↳ '
set breakindent
set breakindentopt=sbr

" https://vimhelp.org/term.txt.html
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
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
set redrawtime=10000
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
let g:loaded_remote_plugins    = 1
" let g:loaded_man               = 1
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
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin    = 1
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovide {{{
" set guifont=Lotion\ Nerd\ Font\ NF:h28
" let g:neovide_cursor_vfx_mode = "torpedo"
" let g:neovide_cursor_vfx_mode = "pixiedust"
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PAQ {{{
command PaqInstall call <sid>loadPaq() | :PaqInstall
command PaqClean   call <sid>loadPaq() | :PaqClean
command PaqUpdate  call <sid>loadPaq() | :PaqUpdate

function s:loadPaq()
  if empty(glob('~/.local/share/nvim/site/pack/paqs/opt/paq-nvim'))
    silent !git clone https://github.com/savq/paq-nvim.git ~/.local/share/nvim/site/pack/paqs/opt/paq-nvim
  endif
  packadd paq-nvim
lua << EOF
local paq = require'paq-nvim'.paq

-- paq {'axvr/photon.vim'}
-- paq {'chriskempson/base16-vim'}

-- paq 'gelguy/wilder.nvim' -- TODO
paq {'aca/nvim-colors'}
-- paq {'tyru/columnskip.vim'}
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
-- paq {'ray-x/lsp_signature.nvim'} -- TODO
paq {'neovim/nvim-lspconfig'}
paq {'glepnir/lspsaga.nvim', opt=true}
paq {'dstein64/nvim-scrollview', opt=true}
paq {'rhysd/clever-f.vim', opt=true}
paq {'vifm/vifm.vim', opt=true} -- replaced with floaterm
paq {'voldikss/vim-floaterm', opt=true}
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

paq {'arp242/switchy.vim', opt=true}

paq {'psliwka/vim-smoothie', opt=true}

paq {'tommcdo/vim-lion', opt=true}
paq {'machakann/vim-sandwich', opt=true}
-- paq {'b3nj5m1n/kommentary', opt=true}
-- paq {'terrortylor/nvim-comment', opt=true}
-- paq {'tpope/vim-commentary', opt=true}
paq {'tomtom/tcomment_vim', opt=true}

paq {'machakann/vim-swap', opt=true}
paq {'aca/fzf-proj.vim', opt=true}
-- paq {'tmsvg/pear-tree', opt=true}
paq {'windwp/nvim-autopairs'}
-- paq {"cohama/lexima.vim"}
paq {'dhruvasagar/vim-table-mode', opt=true}
paq {'tpope/vim-sleuth', opt=true} -- detect indent
paq {'sbdchd/neoformat', opt=true}
paq {'metakirby5/codi.vim', opt=true}
paq {'pedrohdz/vim-yaml-folds', opt=true}
paq {'ferrine/md-img-paste.vim', opt=true}
paq {'buoto/gotests-vim', opt=true}
paq {'110y/vim-go-expr-completion', opt=true}
paq {'iamcco/markdown-preview.nvim', opt=true, hook='yarn install --cwd app/' }
-- paq {'tpope/vim-markdown', opt=true}
paq {'tweekmonster/startuptime.vim', opt=true}
paq {'junegunn/goyo.vim', opt=true}
paq {'monaqa/dial.nvim', opt=true}
-- paq {'tpope/vim-speeddating', opt=true}
paq {'thinca/vim-quickrun', opt=true}
paq {'rhysd/vim-grammarous', opt=true}

-- git
paq {'lambdalisue/gina.vim', opt=true}
-- paq {'tpope/vim-fugitive'}
-- paq {'junegunn/gv.vim'}
paq {'cohama/agit.vim', opt=true}
paq {'mhinz/vim-signify', opt=true}
paq {'rhysd/git-messenger.vim', opt=true}

-- paq {'Rasukarusan/nvim-block-paste', opt=true}
-- paq { 'nvim-lua/plenary.nvim', opt=true}
-- paq { 'lewis6991/gitsigns.nvim', opt=true}

paq {'axvr/zepl.vim', opt=true}
paq {'yamatsum/nvim-cursorline', opt=true}

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
paq {'blankname/vim-fish'}
-- paq {'wlangstroth/vim-racket'}
-- paq {'plasticboy/vim-markdown', opt=true}
-- paq {'rhysd/vim-gfm-syntax', opt=true} -- markdown
-- paq {'rhysd/vim-gfm-syntax'} -- markdown
-- paq {'gabrielelana/vim-markdown', opt=true}
-- paq {'masukomi/vim-markdown-folding'}
paq {'rafkaplon/vim-markdown-folding'}
paq {'plasticboy/vim-markdown', opt=true}

paq {'xolox/vim-colorscheme-switcher', opt=true}
paq {'xolox/vim-misc', opt=true}

-- TODO! https://github.com/JoosepAlviste/nvim-ts-context-commentstring
-- paq {'JoosepAlviste/nvim-ts-context-commentstring'}
-- paq {'nvim-treesitter/nvim-treesitter', hook=":TSUpdate"}

paq {'ThePrimeagen/git-worktree.nvim', opt=true}

EOF
endfunction
" }}}
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
nmap <silent>gr  :packadd vim-ReplaceWithRegister<cr>gr
nmap <silent>grr :packadd vim-ReplaceWithRegister<cr>grr
xmap <silent>gr  <c-u>:packadd vim-ReplaceWithRegister<cr>gr

" nmap <Leader>r  <Plug>ReplaceWithRegisterOperator
" nmap <Leader>rr <Plug>ReplaceWithRegisterLine
" xmap <Leader>r  <Plug>ReplaceWithRegisterVisual


" ap/vim-buftabline {{{
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

autocmd BufAdd * packadd vim-buftabline | :call buftabline#update(0)
" }}}

command! Colorizer packadd nvim-colorizer.lua | :ColorizerToggle

nmap gx :packadd xdg_open.vim<cr>gx
xmap gx :packadd xdg_open.vim \| execute "normal gx"<cr>

let g:quickrun_no_default_key_mappings=1
let g:quickrun_config = {
      \'*': {
      \'outputter/buffer/split': ':15split'}}
nnoremap <silent><Leader>r :packadd vim-quickrun \| :execute "normal \<plug>(quickrun)"<cr><c-w>p
vnoremap <silent><Leader>r <esc>:packadd vim-quickrun \| :execute "normal gv \<plug>(quickrun)"<cr><c-w>p

command! CODI packadd codi.vim | :Codi
command! Grammar packadd vim-grammarous | :GrammarousCheck

" lambdalisue/gina.vim {{{
function s:setup_gina()
  if exists('g:loaded_gina')
    return
  endif
  packadd gina.vim
  cnoreabbrev git Gina
  command! Gbrowse execute "normal! vv" | :'<,'>Gina browse --exact :
  command! Glog :Gina log -- %:p
  command! Agit :packadd agit.vim | :Agit

  " let g:gina#process#command='git'

  " gina show always in vsplit
  call gina#custom#command#option(
          \ '/\%(show\)',
          \ '--opener', 'vsplit'
          \)

  " gina show close with q
  call gina#custom#mapping#nmap(
          \ 'show', 'q',
          \ ':q<CR>',
          \ {'noremap': 1, 'silent': 1},
          \)


  " call gina#custom#mapping#nmap(
  " 	      \ 'log', 'd',
  " 	      \ '0<c-u>:execute "Gina!! diff ".expand("<cword>")[3:]<cr>',
  " 	      \ {'noremap': 1, 'silent': 0},
  " 	      \)

  call gina#custom#mapping#nmap(
          \ 'log', 'q',
          \ ':bd<CR>',
          \ {'noremap': 1, 'silent': 1},
          \)
endfunction
autocmd CursorHold * call <sid>setup_gina()
" }}}

autocmd CursorHold * packadd vim-sleuth

" let g:cursorword_highlight=
" autocmd CursorHold * packadd nvim-cursorline

" junegunn/goyo.vim {{{
let g:goyo_width='100'
let g:goyo_height='100%'
let g:goyo_linenr=0
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

" function! s:goyo_enter()
"   " execute "normal! :ScrollViewEnable"
" endfunction
"
" function! s:goyo_leave()
" endfunction
"
" autocmd! User GoyoEnter nested call <SID>goyo_enter()
" autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}}

" mhinz/vim-signify {{{
let g:signify_sign_show_text = 1
let g:signify_sign_show_count = 0
" let g:signify_disable_by_default = 1
highlight! SignifySignAdd    ctermfg=green  guifg=#696969 cterm=NONE guibg=NONE
highlight! SignifySignDelete ctermfg=red    guifg=#696969 cterm=NONE guibg=NONE
highlight! SignifySignChange ctermfg=yellow guifg=#696969 cterm=NONE guibg=NONE
nmap <silent> ]h <plug>(signify-next-hunk)
nmap <silent> [h <plug>(signify-prev-hunk)
autocmd CursorHold * packadd vim-signify | :SignifyEnable
" }}}

" vim-lion {{{
" tommcdo/vim-lion
" jonasw234/vim-lion " https://github.com/tommcdo/vim-lion/pull/28/files
nmap <silent>gl :packadd vim-lion<cr>gl
nmap <silent>gL :packadd vim-lion<cr>gL
vmap <silent>gl <esc>:packadd vim-lion<cr>gvgl
vmap <silent>gL <esc>:packadd vim-lion<cr>gvgL
let g:lion_squeeze_spaces = 1
" }}}

" vim-sandwich {{{
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
          \     'filetype': ['lua'],
          \     'nesting' : 0,
          \     'input'   : ['p', 'P'],
          \   },
          \ ]
  endif
endfunction

nmap <silent>ds  :call <sid>setup_sandwich()<cr>sd
nmap <silent>dss :call <sid>setup_sandwich()<cr>sdb
nmap <silent>cs  :call <sid>setup_sandwich()<cr>sr
nmap <silent>css :call <sid>setup_sandwich()<cr>srb
xmap <silent>S   <esc>:call <sid>setup_sandwich()<cr>gvsa
" }}}

" sbdchd/neoformat {{{
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_lua = ['luafmt']
" let g:neoformat_async = 1
" }}}

" monaqagdial.nvim {{{
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
" }}}

" windwp/nvim-autopairs {{{
lua << EOF
require('nvim-autopairs').setup({
  disable_filetype = {},
  ignored_next_char = "[%w%.]"
})
EOF
" }}}

" rafcamlet/nvim-luapad {{{
command Luapad packadd nvim-luapad | :Luapad
" }}}

" machakann/vim-swap {{{
let g:swap_no_default_key_mappings = 1
nnoremap <silent>g< :packadd vim-swap \|: execute "normal \<Plug>(swap-prev)"<cr>
nnoremap <silent>g> :packadd vim-swap \|: execute "normal \<Plug>(swap-next)"<cr>
" }}}

" comments {{{

" function s:setup_commentary() 
"   packadd vim-commentary
"   lua <<EOF
" local map = vim.api.nvim_buf_set_keymap
" map(0, 'n', 'gc', [[v:lua.context_commentstring.update_commentstring_and_run('Commentary')]], {expr = true})
" map(0, 'x', 'gc', [[v:lua.context_commentstring.update_commentstring_and_run('Commentary')]], {expr = true})
" map(0, 'o', 'gc', [[v:lua.context_commentstring.update_commentstring_and_run('Commentary')]], {expr = true})
" map(0, 'n', 'gcc', [[v:lua.context_commentstring.update_commentstring_and_run('CommentaryLine')]], {expr = true})
" map(0, 'n', 'cgc', [[v:lua.context_commentstring.update_commentstring_and_run('ChangeCommentary')]], {expr = true})
" EOF
" endfunction
"
" nmap <silent>gcc :call <sid>setup_commentary() \| :exe "normal gcc"<cr>
" vmap <silent>gc <esc>:call <sid>setup_commentary() \| :exe "normal gv gc"<cr>

nmap <silent>gcc :packadd tcomment_vim \| :exe "normal gcc"<cr>
vmap <silent>gc <esc>:packadd tcomment_vim \| :exe "normal gv gc"<cr>

" }}}

" vim-smoothie {{{
nmap <silent><c-d> :packadd vim-smoothie \| :execute "normal \<Plug>(SmoothieDownwards)"<cr>
nmap <silent><c-u> :packadd vim-smoothie \| :execute "normal \<Plug>(SmoothieUpwards)"<cr>
" }}}

" clever-f {{{
nmap <silent>f :packadd clever-f.vim \| :call feedkeys("f")<cr>
" }}}

" phaazon/hop.nvim {{{
nmap <silent><Leader>w :packadd hop.nvim \| :HopWord<cr>
" }}}

" aca/funcs.nvim {{{
xmap s :SortVis<CR>
nnoremap yp :YankPath<cr>
" }}}

" hrsh7th/vim-vsnip {{{
let g:vsnip_filetypes = {
   \ 'sh' : ['bash'],
   \ 'javascriptreact' : ['javascript'],
   \ 'typescriptreact' : ['typescript', 'javascript'],
   \ }
let g:vsnip_snippet_dir = expand('~/.config/nvim/snippets')
" }}}

" hrsh7th/nvim-compe {{{
let g:loaded_compe_ultisnips = 1
let g:loaded_compe_path = 1
let g:loaded_compe_luasnip = 1
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
" }}}

" dstein64/nvim-scrollview {{{
" autocmd CursorHold * packadd nvim-scrollview | :ScrollViewEnable
let g:scrollview_winblend=20
let g:scrollview_base='right'
" }}}

" arecarn/vim-fold-cycle {{{
let g:fold_cycle_default_mapping = 0 "disable default mappings
nmap <silent><cr> :packadd vim-fold-cycle \|:execute "normal \<Plug>(fold-cycle-toggle-all)"<cr>
" }}}

" christoomey/vim-tmux-navigator {{{
nnoremap <silent> <c-h> :packadd vim-tmux-navigator \| :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :packadd vim-tmux-navigator \| :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :packadd vim-tmux-navigator \| :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :packadd vim-tmux-navigator \| :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :packadd vim-tmux-navigator \| :TmuxNavigatePrevious<cr>

tnoremap <c-h> <C-\><C-N>:packadd vim-tmux-navigator \|:TmuxNavigateLeft<cr>
tnoremap <c-j> <C-\><C-N>:packadd vim-tmux-navigator \|:TmuxNavigateDown<cr>
tnoremap <c-k> <C-\><C-N>:packadd vim-tmux-navigator \|:TmuxNavigateUp<cr>
tnoremap <c-l> <C-\><C-N>:packadd vim-tmux-navigator \|:TmuxNavigateRight<cr>
tnoremap <c-\> <C-\><C-N>:packadd vim-tmux-navigator \|:TmuxNavigatePrevious<cr>
" }}}

" RyanMillerC/better-vim-tmux-resizer {{{
let g:tmux_resizer_no_mappings = 1
nnoremap <silent> <m-h> :packadd better-vim-tmux-resizer \| :TmuxResizeLeft<cr>
nnoremap <silent> <m-j> :packadd better-vim-tmux-resizer \| :TmuxResizeDown<cr>
nnoremap <silent> <m-k> :packadd better-vim-tmux-resizer \| :TmuxResizeUp<cr>
nnoremap <silent> <m-l> :packadd better-vim-tmux-resizer \| :TmuxResizeRight<cr>
" }}}

" lambdalisue/suda.vim
command! SudoWrite packadd suda.vim | :SudaWrite
command! SudoRead packadd suda.vim | :SudaRead

command! GitMessenger packadd git-messenger.vim | :GitMessenger
nnoremap gm :GitMessenger<cr>

" bronson/vim-visual-star-search {{{
function! VisualStarSearchSet(cmdtype,...)
  let temp = @"
  normal! gvy
  if !a:0 || a:1 != 'raw'
    let @" = escape(@", a:cmdtype.'\*')
  endif
  let @/ = substitute(@", '\n', '\\n', 'g')
  let @/ = substitute(@/, '\[', '\\[', 'g')
  let @/ = substitute(@/, '\~', '\\~', 'g')
  let @/ = substitute(@/, '\.', '\\.', 'g')
  let @" = temp
endfunction
xnoremap * :<C-u>call VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>
" }}}

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NVIM-LSP {{{

lua << EOF
-- require '_lsp'
local nvim_lsp = require'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- nvim_lsp.tsserver.setup{} -- Need typescript installed to use for javascript project
nvim_lsp.gopls.setup{}
-- nvim_lsp.racket_langserver.setup{ capabilities = capabilities; }
-- nvim_lsp.bashls.setup{ capabilities = capabilities; }
-- nvim_lsp.vimls.setup { capabilities = capabilities; }
-- nvim_lsp.cssls.setup{ capabilities = capabilities; }
-- nvim_lsp.dockerls.setup{ capabilities = capabilities; }
-- nvim_lsp.html.setup{ capabilities = capabilities; }
-- nvim_lsp.jsonls.setup { capabilities = capabilities; }
-- nvim_lsp.yamlls.setup { capabilities = capabilities; }
nvim_lsp.clangd.setup{ capabilities = capabilities; }
-- nvim_lsp.rust_analyzer.setup { capabilities = capabilities; }

-- https://www.reddit.com/r/neovim/comments/mrep3l/speedup_your_prettier_formatting_using_prettierd/
nvim_lsp.denols.setup{
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" , "json"},
  root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", ".git", vim.fn.getcwd()),
  settings = {
    init_options = {
      enable = true,
      lint = true,
      unstable = false
    }
  }
}

-- nvim_lsp.pyright.setup{}
require 'pylance'
nvim_lsp.pylance.setup{
  settings = {
    python = {
      analysis = {
        -- typeCheckingMode = "strict"
      }
    }
  };
  -- capabilities = capabilities;
}

local sumneko_root_path = vim.fn.expand('$HOME/src/github.com/sumneko/lua-language-server')
nvim_lsp.sumneko_lua.setup{
  cmd = { sumneko_root_path .. "/bin/".. vim.g._uname .. "/lua-language-server", "-E", sumneko_root_path .. "/main.lua"};
  settings = {
      Lua = {
          runtime = {
              -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
          },
          diagnostics = {
              globals = {'vim'},
          },
          workspace = {
              library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              },
          },
          telemetry = {
            enable = false,
          },
      },
  },
}

-- nvim_lsp.configs.korean_ls = {
--   default_config = {
--     cmd = {'korean-ls', '--stdio'};
--     filetypes = {'text'};
--     root_dir = function()
--       return vim.loop.cwd()
--     end;
--     settings = {};
--   };
-- }
-- nvim_lsp.korean_ls.setup{}


-- neuron language server
-- nvim_lsp.configs.neuron_ls = {
-- default_config = {
--     -- cmd = {'neuron', 'lsp'};
--     cmd = {'neuron-language-server'};
--     filetypes = {'markdown'};
--     root_dir = function()
--       return vim.loop.cwd()
--     end;
--     settings = {};
--   };
-- }
-- nvim_lsp.neuron_ls.setup{}

-- emmet language server
-- nvim_lsp.configs.emmet_ls = {
--   default_config = {
--     cmd = {'emmet-ls', '--stdio'};
--     filetypes = {'html', 'css'};
--     root_dir = function()
--       return vim.loop.cwd()
--     end;
--     settings = {};
--   };
-- }
-- nvim_lsp.emmet_ls.setup{}

require'compe'.setup {
  enabled = true;
  debug = false;
  preselect = 'disable';
  min_length = 1;
  -- -- throttle_time = ... number ...;
  -- -- source_timeout = ... number ...;
  -- -- incomplete_delay = ... number ...;
  allow_prefix_unmatch = true;
  documentation = true;
  --
  source = {
    path = true;
    buffer = true;
    vsnip = true;
    nvim_lsp = true;
    -- calc = true;
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
  if vim.fn.call("vsnip#jumpable", {1}) == 1 then
    return t "<Plug>(vsnip-jump-next)"
  elseif vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  else
    return t "<Tab>"
--  elseif check_back_space() then
--    return t "<Tab>"
--  else
--    return vim.fn['compe#complete']()
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

-- TODO: treesitter
-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--   highlight = {
--     enable = true,              -- false will disable the whole extension
--     -- disable = { "c", "rust" },  -- list of language that will be disabled
--   },
--   -- context_commentstring = {
--   --   enable = true
--   -- },
-- }

EOF

function s:formatting()
  try 
    lua vim.lsp.buf.formatting()
  catch
    packadd neoformat
    execute ":Neoformat"
  endtry
endfunction


set completeopt=menu,menuone,noselect

nnoremap <silent> gD            <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gd            <cmd>vsplit<bar>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> gd            <cmd>vsplit<bar>lua vim.lsp.buf.definition()<CR><c-w><c-p>
nnoremap <silent> gi            <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gt            <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> pd            <cmd>lua vim.lsp.buf.peek_definition()<CR>
nnoremap <silent> g0            <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW            <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> gr          :LspSagaFinder<CR>

" lua require'lspsaga.diagnostic'.show_line_diagnostics()
" nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
" inoremap <silent> <c-k> <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
"
nnoremap <silent> ]d            <cmd>lua vim.lsp.diagnostic.goto_next({wrap = false})<CR>
nnoremap <silent> [d            <cmd>lua vim.lsp.diagnostic.goto_prev({wrap = false})<CR>
" nnoremap <silent> ;d            <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> ;d            <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> ;r            <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> ;n            <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <silent> ;a            <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <silent> ;a            <cmd>lua vim.lsp.buf.range_code_action()<CR>

nnoremap <silent> ;f           <cmd>call <sid>formatting()<cr>
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
inoremap <silent><expr><CR>     compe#confirm('<CR>')

hi! link LspDiagnosticsDefaultInformation Comment
hi! link LspDiagnosticsDefaultHint Comment
hi! link LspDiagnosticsDefaultError Comment
hi! link LspDiagnosticsDefaultWarning Comment
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GO {{{
" open test (toggle test)
nnoremap <silent> <leader>tt :call switchy#switch('edit', 'edit')<CR>
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCMD {{{

" Autoclose terminal without prompt
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" autocmd BufWinEnter,WinEnter term://* nnoremap

" autocmd BufWinEnter,WinEnter term://* nnoremap <silent> <c-h> :packadd vim-tmux-navigator \| :TmuxNavigateLeft<cr>
" autocmd BufWinEnter,WinEnter term://* nnoremap <silent> <c-j> :packadd vim-tmux-navigator \| :TmuxNavigateDown<cr>
" autocmd BufWinEnter,WinEnter term://* nnoremap <silent> <c-k> :packadd vim-tmux-navigator \| :TmuxNavigateUp<cr>
" autocmd BufWinEnter,WinEnter term://* nnoremap <silent> <c-l> :packadd vim-tmux-navigator \| :TmuxNavigateRight<cr>
" autocmd BufWinEnter,WinEnter term://* nnoremap <silent> <c-\> :packadd vim-tmux-navigator \| :TmuxNavigatePrevious<cr>

" Highlight TODO
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

" justfile
" au! BufNewFile,BufRead justfile setf make

" https://github.com/vim/vim/blob/master/runtime/defaults.vim
au BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" comment for no file
au BufWinEnter,BufAdd * if (&ft =="") | setlocal commentstring=#\ %s | endif

" https://stackoverflow.com/questions/630884/opening-vim-help-in-a-vertical-split-window
" au FileType help wincmd L

" if there's no other window but quickfix close it
au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS {{{
" https://vim.fandom.com/wiki/Unused_keys

" " gf that works with vim-fetch
" - ~/src/ (directory)
" - ~/src (it sometimes does not open directory properly)
" ~/.config/nvim/init.vim:9^2 (cursor at ^)
nnoremap <silent>gf WBgF

" visual block increment
vnoremap <C-a> g<C-a>
vnoremap <C-x> g<C-x>
vnoremap g<C-a> <C-a>
vnoremap g<C-x> <C-x>
nnoremap <c-g> 2<c-g>

imap <C-d> ##<ESC>:r! date "+\%H:\%M \%a \%m/\%d/\%Y"<CR>kJ$a<cr>

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


"" Split
nnoremap <leader>o :only<cr>
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
command! Fish terminal fish
" nnoremap <leader>s :botright 10sp<bar>  :Fish<cr>i
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

" close window, or buffer, or exit
function s:close()
  if winnr('$') != 1 
    close
  elseif len(getbufinfo({'buflisted':1})) > 1
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

nnoremap <expr>   <bslash>f &foldlevel ? 'zM' :'zR'
nnoremap <silent> <bslash>w :set wrap!<CR>
nnoremap <silent> <bslash>n :set number! \| set relativenumber!<CR>
nnoremap <silent> <bslash>z :packadd goyo.vim \| :silent! Goyo<CR>
nnoremap <silent> <bslash>s
             \ : if exists("syntax_on") <BAR>
             \    syntax off <BAR>
             \ else <BAR>
             \    syntax enable <BAR>
             \ endif<CR>
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXPLORER {{{
function s:vifm()
  let g:floaterm_opener="edit"
  packadd vim-floaterm
  if expand('%:p') != "" 
    FloatermNew --height=0.9 --width=0.9 --title=vifm vifm --select '%:p'
  else
    FloatermNew --height=0.9 --width=0.9 --title=vifm vifm -c ':vs |:tree! | :view! | set nodotfiles'
  end
endfunction

command! DiffVifm packadd vifm.vim | :DiffVifm
nnoremap <silent><c-e> <cmd>call <sid>vifm()<CR>
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF {{{
let g:loaded_fzf=2 " to skip fzf.vim filetype script (/usr/share/vim/vimfiles/plugin/fzf.vim)
function s:setup_fzf() 
  if g:loaded_fzf != 2
    return
  endif
  unlet g:loaded_fzf

  " set rtp+=/usr/local/bin
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }

  " Rg without filename
  " command! -bang -nargs=* Rgg call fzf#vim#grep('rg --column --line-number --color=always --no-heading --line-number --smart-case -- 2>/dev/null '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4.. ', 'window': { 'width': 0.4, 'height': 0.4 }}), 0)
  command! -bang -nargs=* Rgg call fzf#vim#grep('rg --column --line-number --color=always --no-heading --line-number --smart-case -- 2>/dev/null '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4.. '}), 0)

  " https://github.com/junegunn/fzf/issues/1143
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=0 showmode ruler
  au FileType fzf tnoremap <buffer> <Esc> <c-c>
  let g:fzf_preview_window = ['right:50%', 'ctrl-/']
  let $FZF_DEFAULT_OPTS = '--inline-info --color "gutter:-1"  '
  let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }
  let g:fzf_buffers_jump = 1 " [Buffers] Jump to the existing window if possible

  " fzf mark with preview
  function! s:fzfmarks() abort
    return call('fzf#vim#with_preview', [{'options': '--preview-window +{2}-/2', 'placeholder': '$([ -r $(echo {4} | sed "s#^~#$HOME#") ] && echo {4} || echo ' . fzf#shellescape(expand('%')) . '):{2}'}, 'up:50%', 'ctrl-/'])
  endfunction
  command! -bar -bang FZFMarks execute ':call s:setup_fzf() | call fzf#vim#marks(s:fzfmarks(), 0)'

  let g:fzf#proj#project_dir="$HOME/src"
  let g:fzf#proj#max_proj_depth=5
  
  packadd fzf
  packadd fzf.vim
endfunction
nnoremap <silent><c-f>                :call <sid>setup_fzf()   \|         :Rgg<cr>
inoremap <silent><c-f>                <c-o>:call <sid>setup_fzf()   \|    :Rgg<cr>
nnoremap <silent><leader>fa           :call <sid>setup_fzf()   \|         :Rgg<cr>
nnoremap <silent><Leader>fw           :call <sid>setup_fzf()   \|         :Rg <C-R><C-W><CR>
nnoremap <silent><Leader>fW           g :call <sid>setup_fzf() \|         :Rg <C-R><C-A><CR>
vnoremap <silent><Leader>fw           y :call <sid>setup_fzf() \|         :Rg <C-R>"<CR>
nnoremap <silent><Leader>fm           :call <sid>setup_fzf()   \|         :FZFMarks<cr>
nnoremap <silent><leader>fl           :call <sid>setup_fzf()   \|         :BLines<cr>
nnoremap <silent><leader>ff           :call <sid>setup_fzf()   \|         :Files<cr>
nnoremap <silent><leader>fh           :call <sid>setup_fzf()   \|         :History<CR>
nnoremap <silent><leader>'            :call <sid>setup_fzf()   \|         :FZFMarks<cr>
nnoremap <silent><leader>b            :call <sid>setup_fzf()   \|         :Buffers<cr>
nnoremap <silent><leader>fC           :call <sid>setup_fzf()   \|         :Colors<cr>
nnoremap <silent><leader>fc           :call <sid>setup_fzf()   \|         :Commits<cr>
nnoremap <silent><leader>fp           :call <sid>setup_fzf()   \|         :packadd fzf-proj.vim  \|  :Projects<cr>
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
" silent! source $HOME/.config/nvim/$HOSTNAME.vim
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STARTIFY {{{
function s:startify()
  function! s:gitModified()
      let files = systemlist('git ls-files -m 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
  endfunction

  " same as above, but show untracked files, honouring .gitignore
  function! s:gitUntracked()
      let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
  endfunction

  let g:startify_change_to_vcs_root = 1
  let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
          \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]
  let g:startify_custom_header = ''
  packadd vim-startify
endfunction
nnoremap <silent><leader>x :call <sid>startify()\|Startify<cr>
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UTILS {{{
command! NeuronUpdate silent! exe '1,5s/^date: 2.*/date: '. strftime("%Y-%m-%dT%H:%M")
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

