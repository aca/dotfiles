" vim: foldmethod=marker

" lua require 'utils'

" lua vim.lsp.set_log_level("debug")

let syntax_manual=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DEFAULTS {{{
let g:_uname = 'macOS' | if has('unix') | let g:_uname = 'Linux' | endif
    
"  ShaDa/viminfo:
"   ' - Maximum number of previously edited files marks
"   < - Maximum number of lines saved for each register
"   @ - Maximum number of items in the input-line history to be
"   s - Maximum size of an item contents in KiB
"   h - Disable the effect of 'hlsearch' when loading the shada
set shada='300,<10,@50,s100,h
set scrolloff=5


" if filereadable("/usr/bin/sh") | set shell=/usr/bin/sh | elseif filereadable("/bin/sh") | set shell=/bin/sh | endif

let &statusline ="%f%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''} %= | %l:%c |%P"

set laststatus=2

set listchars=tab:\ ──,space:·,nbsp:␣,trail:•,eol:↵,precedes:«,extends:»
set showbreak=⤷\ 

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
set regexpengine=1
set conceallevel=1

set inccommand=split
set wildoptions=pum
set pumblend=30
tnoremap <Esc> <C-\><C-n>

set splitbelow
set splitright

set hidden " zepl.vim

" autocmd TermOpen * startnormal

" ctags
set tags=./tags;/

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
set formatoptions+=jcql
set hidden
set hlsearch
set ignorecase
set incsearch
set isfname-==
set lazyredraw
set redrawtime=20000
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
" set virtualedit=all
" set visualbell
set whichwrap=b,s
" set wildmenu
" set wildmode=full
set wrapmargin=0
set nocursorcolumn
set cursorline " lag in redraw scrreen

" get rid of fold char
set fillchars=fold:\ 

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
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Neovide {{{
set guifont=Lotion\ Nerd\ Font\ NF:h28
" let g:neovide_cursor_vfx_mode = "torpedo"
" let g:neovide_cursor_vfx_mode = "pixiedust"
"
" set guifont=Fira_Code:h30
" " }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS CONFIG {{{
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | packadd vim-oscyank | silent OSCYankReg " | endif
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | packadd vim-oscyank | silent OSCYankReg + | endif

" Lazy load
function! LazyLoad(timer)
  source ~/.config/nvim/lazy.vim
endfunction

autocmd VimEnter * call timer_start(50, "LazyLoad")

" ap/vim-buftabline {{{
function s:setup_buftabline()
  if exists('g:loaded_buftabline')
    return
  endif
  let g:loaded_buftabline = 1
  packadd vim-buftabline
  call buftabline#update(0)
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
endfunction

autocmd BufAdd * call <sid>setup_buftabline()
" }}}

" sbdchd/neoformat {{{
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_lua = ['luafmt']
let g:neoformat_enabled_go = ['gofumports']
" let g:neoformat_async = 1
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

if getcwd() != "/home/rok/src/zettels"
  let g:loaded_compe_tabnine = 1
endif

" let g:loaded_compe_buffer = 1
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

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lsp / compe {{{

" https://github.com/stevearc/aerial.nvim
" https://github.com/simrat39/symbols-outline.nvim
" Symbol plugin
let g:aerial = {
   \ 'max_width' : 200,
   \ 'min_width' : 30,
   \ }

lua << EOF
local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'    
-- require'lsp_signature'.on_attach()
-- require'aerial'.on_attach()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.tsserver.setup{ capabilities = capabilities; } -- Need typescript installed to use for javascript project
lspconfig.gopls.setup{ capabilities = capabilities; }
lspconfig.hls.setup{ capabilities = capabilities; }
-- lspconfig.racket_langserver.setup{ capabilities = capabilities; }
-- nvim_lsp.bashls.setup{ capabilities = capabilities; }
-- nvim_lsp.vimls.setup { capabilities = capabilities; }
-- nvim_lsp.cssls.setup{ capabilities = capabilities; }
-- nvim_lsp.dockerls.setup{ capabilities = capabilities; }
-- nvim_lsp.html.setup{ capabilities = capabilities; }
-- nvim_lsp.jsonls.setup { capabilities = capabilities; }
-- nvim_lsp.yamlls.setup { capabilities = capabilities; }
-- nvim_lsp.rust_analyzer.setup { capabilities = capabilities; }
lspconfig.clangd.setup{ capabilities = capabilities; }

-- https://www.reddit.com/r/neovim/comments/mrep3l/speedup_your_prettier_formatting_using_prettierd/
-- nvim_lsp.denols.setup{
--   filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" , "json"},
--   root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", ".git", vim.fn.getcwd()),
--   settings = {
--     init_options = {
--       enable = true,
--       lint = true,
--       unstable = false
--     }
--   }
-- }

require 'pylance'
lspconfig.pylance.setup{
  capabilities = capabilities; 
  settings = {
    python = {
      analysis = {
        -- typeCheckingMode = "strict"
      }
    }
  };
}

local sumneko_root_path = vim.fn.expand('$HOME/src/github.com/sumneko/lua-language-server')
local luadev = require("lua-dev").setup({
  -- add any options here, or leave empty to use the default settings
  lspconfig = {
    cmd = { sumneko_root_path .. "/bin/".. vim.g._uname .. "/lua-language-server", "-E", sumneko_root_path .. "/main.lua"};
    capabilities = capabilities;
  },
})


lspconfig.sumneko_lua.setup(luadev)

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

-- if not lspconfig.emmet_ls then    
--   configs.emmet_ls = {    
--     default_config = {    
--       cmd = {'emmet-ls', '--stdio'};
--       filetypes = {'html', 'css'};
--       root_dir = function(fname)    
--         return vim.loop.cwd()
--       end;    
--       settings = {};    
--     };    
--   }    
-- end    

-- lspconfig.emmet_ls.setup{ capabilities = capabilities; }

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
    tabnine = true;
    -- tmux = true;
    nvim_lsp = true;
    -- omni = true;
    -- calc = true;
    -- nvim_lua = { ... overwrite source configuration ... };
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
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


function s:formatter(command)
  packadd neoformat

  if a:command == "Neoformat"
    execute ":Neoformat"
    return
  endif

  try 
    lua vim.lsp.buf.formatting()
  catch
    execute ":Neoformat"
  endtry
endfunction

set completeopt=menu,menuone,noselect

nnoremap <silent> gD            <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gd            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gd            <cmd>vsplit<bar>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> gd            <cmd>call <sid>lsp_definition()<CR>
" nnoremap <silent> gd            <cmd>vsplit<bar>lua vim.lsp.buf.definition()<CR><c-w><c-p>
nnoremap <silent> gt            <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> pd            <cmd>lua vim.lsp.buf.peek_definition()<CR>
nnoremap <silent> g0            <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW            <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> gr          :LspSagaFinder<CR>

" lua require'lspsaga.diagnostic'.show_line_diagnostics()
" nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
" inoremap <silent> <c-k> <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

nnoremap <silent> ]d            <cmd>lua vim.lsp.diagnostic.goto_next({wrap = false})<CR>
nnoremap <silent> [d            <cmd>lua vim.lsp.diagnostic.goto_prev({wrap = false})<CR>
" nnoremap <silent> ;s            <cmd>SymbolsOutline<cr>
nnoremap <silent> ;s            <cmd>AerialToggle<cr>
nnoremap <silent> ]s            <cmd>AerialNext<cr>
nnoremap <silent> [s            <cmd>AerialPrev<cr>

nnoremap <silent> ;d            <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> ;dd           <cmd>lua vim.lsp.diagnostic.set_loclist()<cr>
nnoremap <silent> ;r            <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> ;n            <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <silent> ;a            <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <silent> ;a            <cmd>lua vim.lsp.buf.range_code_action()<CR>
nnoremap <silent> ;i            <cmd>lua vim.lsp.buf.implementation()<CR>

nnoremap <silent> ;f            <cmd>call <sid>formatter("")<cr>
nnoremap <silent> ;ff           <cmd>call <sid>formatter("Neoformat")<cr>
imap <expr><C-j>                vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-j>'
inoremap <silent><expr><CR>     compe#confirm('<CR>')
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCMD {{{
au BufReadPost *.rkt,*.rktl setfiletype scheme
autocmd BufRead,BufNewFile *.fish setfiletype fish

" https://github.com/vim-pandoc/vim-pandoc-syntax
" au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost cgetexpr set ft=qf
augroup END

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

" https://github.com/vim/vim/blob/master/runtime/defaults.vim
au BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" comment for no file
au BufWinEnter,BufAdd * if (&ft =="") | setlocal commentstring=#\ %s | endif
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

" imap <C-d> ##<ESC>:r! date "+\%H:\%M \%a \%m/\%d/\%Y"<CR>kJ$a<cr>
imap <C-d> <ESC>:r! date "date +\%Y-\%m-\%d"<CR>kJ$a<cr>


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
cnoreabbrev Qa qa
cnoreabbrev Qall qall
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
nnoremap [j g;
nnoremap ]j g,
nnoremap [c :packadd vim-misc \| packadd vim-colorscheme-switcher \| :NextColorScheme<cr>
nnoremap ]c :packadd vim-misc \| packadd vim-colorscheme-switcher \| :PrevColorScheme<cr>

" Split
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
inoremap <C-Q>     <esc>:call <sid>close()<cr>
nnoremap <C-Q>     :call <sid>close()<cr>
vnoremap <C-Q>     <esc>:call <sid>close()<cr>

" Save
inoremap <C-s>     <esc>:update<cr>
nnoremap <C-s>     :update<cr>
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TOGGLE {{{
nnoremap <expr>   <bslash>f &foldlevel ? 'zM' :'zR'
nnoremap <silent> <bslash>w :set wrap!<CR>
nnoremap <silent> <bslash>n :set number! \| set relativenumber!<CR>
nnoremap <silent> <bslash>s
             \ : if exists("syntax_on") <BAR>
             \    syntax off <BAR>
             \ else <BAR>
             \    syntax enable <BAR>
             \ endif<CR>
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
  command! -bang -nargs=* Rgg call fzf#vim#grep('rg --column --line-number --color=always --no-heading --line-number --smart-case -- 2>/dev/null '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4.. '}), 0)
  command! -bang -nargs=* RggWithFile call fzf#vim#grep('rg --column --line-number --color=always --no-heading --line-number --smart-case -- 2>/dev/null '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 1.. '}), 0)

  " https://github.com/junegunn/fzf/issues/1143
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
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
" inoremap <silent><c-f>                <c-o>:call <sid>setup_fzf()   \|    :Rgg<cr>
inoremap <silent><c-f>                <esc>la
nnoremap <silent><m-f>                :call <sid>setup_fzf()   \|         :RggWithFile<cr>
nnoremap <silent><m-f>                <c-o>:call <sid>setup_fzf()   \|    :RggWithFile<cr>
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
" COLORS {{{
" colorscheme monokai_pro
" colorscheme codedark
" colorscheme vscode-dark
" colorscheme tomorrow-night
colorscheme substrata
" colorscheme base16-tomorrow-night-eighties
" colorscheme base16-tomorrow-night
" colorscheme tomorrow-night

hi! link LspDiagnosticsDefaultInformation Comment
hi! link LspDiagnosticsDefaultHint Comment
hi! link LspDiagnosticsDefaultError Comment
hi! link LspDiagnosticsDefaultWarning Comment
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HOST SPECIFIC {{{
" silent! source $HOME/.config/nvim/$HOSTNAME.vim

if g:_uname == "linux"
  autocmd InsertLeave * silent call system("fcitx5-remote -c")
  autocmd VimEnter * silent call system("fcitx5-remote -c")
end
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEMPLATE {{{
augroup _template
autocmd BufNewFile ~/src/zettels/[^/]\\\{1,100\}.md 0r! ~/src/configs/dotfiles/.config/nvim/templates/zettels.sh
autocmd BufNewFile ~/src/zettels/dev/**.md 0r! ~/src/configs/dotfiles/.config/nvim/templates/zettels.sh
autocmd BufNewFile ~/src/zettels/log/*.md 0r! ~/src/configs/dotfiles/.config/nvim/templates/zettels.sh "$(date +\%Y-\%m-\%d)"
augroup end
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command GetVisualSelect <c-u>lua print("getvisual")
xnoremap <leader><leader>a :<C-U> call GetVisualSelection(visualmode())<Cr>
xnoremap <leader>a :<c-u>lua require('utils').get_visual_selection()<cr>
vnoremap <leader>a :<c-u>lua require('utils').get_visual_selection()<cr>

" https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
" https://github.com/neovim/neovim/pull/13896/files " TODO: check updates
function! GetVisualSelection(mode)
    " call with visualmode() as the argument
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end]     = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if a:mode ==# 'v'
        " Must trim the end before the start, the beginning will shift left.
        let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
        let lines[0] = lines[0][column_start - 1:]
    elseif  a:mode ==# 'V'
        " Line mode no need to trim start or end
    elseif  a:mode == "\<c-v>"
        " Block mode, trim every line
        let new_lines = []
        let i = 0
        for line in lines
            let lines[i] = line[column_start - 1: column_end - (&selection == 'inclusive' ? 1 : 2)]
            let i = i + 1
        endfor
    else
        return ''
    endif
    for line in lines
        echom line
    endfor
    return join(lines, "\n")
endfunction


autocmd TermEnter zepl:* tnoremap <C-\><C-n> <C-\><C-n>G

" autocmd TermEnter zepl:* tnoremap <C-\><C-N> <C-\><C-n>G
autocmd TermLeave,InsertLeave,BufLeave zepl:* normal! G
" autocmd TermLeave,InsertLeave zepl:* normal! G

" http://neovim.io/news/2021/07
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}



