" vim: foldmethod=marker

packadd nvim-treesitter
packadd nvim-ts-rainbow

" }}}

" machakann/vim-swap {{{
let g:swap_no_default_key_mappings = 1
packadd vim-swap
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)

packadd hop.nvim
lua require'hop'.setup()
" packadd clever-f.vim

packadd xdg_open.vim
let g:xdg_open_command='xdg-open'
let g:netrw_browsex_viewer='xdg-open'

let test#strategy = "neovim"
packadd vim-test

" vim-quickrun {{{
let g:quickrun_no_default_key_mappings=1
let g:quickrun_config = {
      \'*': {
      \'outputter/buffer/split': ':10split'}}
packadd vim-quickrun
nnoremap <silent><Leader>r :QuickRun -mode n<cr>
vnoremap <silent><Leader>r :QuickRun -mode v<cr>
" }}}

" https://github.com/tommcdo/vim-lion {{{
" https://github.com/tommcdo/vim-lion/pull/28/files
let g:lion_squeeze_spaces = 1
packadd vim-lion
" }}}

" zepl.vim {{{
autocmd TermLeave,InsertLeave,BufLeave zepl:* normal! G
let g:repl_config = {
            \   'python': {
            \     'cmd': 'ipython',
            \     'formatter': function('zepl#contrib#python#formatter')
            \   }
            \ }
packadd zepl.vim
runtime zepl/contrib/python.vim  " Enable the Python contrib module.
runtime zepl/contrib/nvim_autoscroll_hack.vim
" }}}

" matze/vim-move {{{
let g:move_map_keys = 0
packadd vim-move
vmap <M-j> <Plug>MoveBlockDown
vmap <M-k> <Plug>MoveBlockUp
vmap <M-h> <Plug>MoveBlockLeft
vmap <M-l> <Plug>MoveBlockRight

vmap <A-s> <Plug>MoveBlockDown
vmap <A-w> <Plug>MoveBlockUp
vmap <A-a> <Plug>MoveBlockLeft
vmap <A-d> <Plug>MoveBlockRight

nmap <M-s> <Plug>MoveLineDown
nmap <M-w> <Plug>MoveLineUp
nmap <M-a> <Plug>MoveCharLeft
nmap <M-d> <Plug>MoveCharRight
" }}}

" https://github.com/gennaro-tedesco/nvim-peekup {{{
" packadd nvim-peekup
" lua require('nvim-peekup.config').on_keystroke["delay"] = ''
" }}}

" lambdalisue/gina.vim {{{
packadd gina.vim
cnoreabbrev Git Gina
" command! Gbrowse execute "normal! vv" | :'<,'>Gina browse --exact :
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

call gina#custom#mapping#nmap(
        \ 'log', 'd',
        \ ':execute printf(":new term://git diff %s \| resize +10", gina#action#candidates()[0].rev)<cr>',
        \ {'noremap': 1, 'silent': 1},
        \)

call gina#custom#mapping#nmap(
        \ 'log', 'q',
        \ ':bd<CR>',
        \ {'noremap': 1, 'silent': 1},
        \)

" %domain in the acceptable url pattern list will be substituted into
" 'gitlab.hashnote.net'
" '_' of a url translation scheme dictionary is used as a default
" scheme
" '^' of a url translation scheme dictionary is used as a repository
" scheme
call extend(g:gina#command#browse#translation_patterns, {
    \ 'k8s.io': [
    \   [
    \     '\vhttps?://(%domain)/(.{-})/(.{-})%(\.git)?$',
    \     '\vgit://(%domain)/(.{-})/(.{-})%(\.git)?$',
    \     '\vgit\@(%domain):(.{-})/(.{-})%(\.git)?$',
    \     '\vssh://git\@(%domain)/(.{-})/(.{-})%(\.git)?$',
    \   ], {
    \     'root':  'https://\1/\2/\3/tree/%r1/',
    \     '_':     'https://\1/\2/\3/blob/%r1/%pt%{#L|}ls%{-}le',
    \     'exact': 'https://\1/\2/\3/blob/%h1/%pt%{#L|}ls%{-}le',
    \   },
    \ ],
    \})

" }}}

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

" dstein64/nvim-scrollview {{{
" autocmd CursorHold * packadd nvim-scrollview | :ScrollViewEnable
" let g:scrollview_winblend=20
" let g:scrollview_base='right'
" }}}

" mhinz/vim-signify {{{
" let g:signify_sign_show_text = 1
" let g:signify_sign_show_count = 0
" " let g:signify_disable_by_default = 1
" highlight! SignifySignAdd    ctermfg=green  guifg=#696969 cterm=NONE guibg=NONE
" highlight! SignifySignDelete ctermfg=red    guifg=#696969 cterm=NONE guibg=NONE
" highlight! SignifySignChange ctermfg=yellow guifg=#696969 cterm=NONE guibg=NONE
" nmap <silent> ]h <plug>(signify-next-hunk)
" nmap <silent> [h <plug>(signify-prev-hunk)
" autocmd User DeferLoad packadd vim-signify | :SignifyEnable
" }}}

" rafcamlet/nvim-luapad {{{
command Luapad packadd nvim-luapad | :Luapad
" }}}

" phaazon/hop.nvim {{{
nmap <silent><Leader>w :HopWord<cr>
" }}}


" lambdalisue/suda.vim {{{
command! SudoWrite packadd suda.vim | :SudaWrite
command! SudoRead packadd suda.vim | :SudaRead
" }}}

" https://github.com/rhysd/git-messenger.vim {{{
command! GitMessenger packadd git-messenger.vim | :GitMessenger
nnoremap gm :GitMessenger<cr>
" }}}


" settings {{{
" if there's no other window but quickfix close it
au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif

" set formatoptions-=ro

" Highlight TODO
autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)

" Autoclose terminal without prompt
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" https://stackoverflow.com/questions/630884/opening-vim-help-in-a-vertical-split-window
" au FileType help wincmd L

" 0 goes to first https://github.com/yuki-yano/zero.nvim/blob/main/lua/zero.lua
lua vim.api.nvim_set_keymap('n', '0', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", {silent = true, noremap = true, expr = true})

" }}}

" GO {{{
" open test (toggle test)
nnoremap <silent> <leader>tt :call switchy#switch('edit', 'edit')<CR>
" }}}

lua << EOF
EOF

" GREP {{{
" call grepprg in a system shell instead of internal shell
" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
function! Grep(...)
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

set grepprg=rg\ --vimgrep\ --no-heading
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
" }}}
"
" VIFM {{{
function s:vifm()
  let g:floaterm_opener="edit"
  packadd vim-floaterm
  if expand('%:p') != "" 
    FloatermNew --height=0.9 --width=0.9 --title=vifm vifm --select '%:p'
  else
    FloatermNew --height=0.9 --width=0.9 --title=vifm vifm -c ':vs |:tree! | :view! | set nodotfiles'
  end
endfunction

command! DiffVifm :DiffVifm
nnoremap <silent><c-e> <cmd>call <sid>vifm()<cr>
" }}}

" vim-sandwich {{{
packadd vim-sandwich

" sa surround add
" sd surround delete
" sr surround replace
" vim-surround replacement
runtime macros/sandwich/keymap/surround.vim

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
      \     'buns'    : ['
      \```', '```
      \'],
      \     'filetype': ['markdown'],
      \     'nesting' : 0,
      \     'input'   : ['c','C'],
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
" }}}

" " RyanMillerC/better-vim-tmux-resizer {{{
" packadd better-vim-tmux-resizer
" let g:tmux_resizer_no_mappings = 1
" nnoremap <silent> <m-h> <cmd>TmuxResizeLeft<cr>
" nnoremap <silent> <m-j> <cmd>TmuxResizeDown<cr>
" nnoremap <silent> <m-k> <cmd>TmuxResizeUp<cr>
" nnoremap <silent> <m-l> <cmd>TmuxResizeRight<cr>
" " }}}
" " christoomey/vim-tmux-navigator {{{
" packadd vim-tmux-navigator
" nnoremap <silent> <c-h> <cmd>TmuxNavigateLeft<cr>
" nnoremap <silent> <c-j> <cmd>TmuxNavigateDown<cr>
" nnoremap <silent> <c-k> <cmd>TmuxNavigateUp<cr>
" nnoremap <silent> <c-l> <cmd>TmuxNavigateRight<cr>
"
" tnoremap <c-h> <C-\><C-N><cmd>TmuxNavigateLeft<cr>
" tnoremap <c-j> <C-\><C-N><cmd>TmuxNavigateDown<cr>
" tnoremap <c-k> <C-\><C-N><cmd>TmuxNavigateUp<cr>
" tnoremap <c-l> <C-\><C-N><cmd>TmuxNavigateRight<cr>

" packadd alexghergh/nvim-tmux-navigation
" nnoremap <silent> <C-h> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>
" nnoremap <silent> <C-j> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>
" nnoremap <silent> <C-k> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>
" nnoremap <silent> <C-l> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>
" nnoremap <silent> <C-\> :lua require'nvim-tmux-navigation'.NvimTmuxNavigatePrevious()<cr>
" " }}}

" https://github.com/windwp/nvim-autopairs {{{
packadd nvim-autopairs 
lua <<EOF

require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true -- automatically select the first item
})

require('nvim-autopairs').setup({
  check_ts = true
})
EOF
" }}}

lua <<EOF
-- require '_treesitter'
-- require '_gitsigns'
require '_dial'
require '_zenmode'
-- require '_dap'
-- require '_paq'
-- require '_dadbod'
EOF

" utils {{{

" :Chomp | remove trailing whitespaces
command! Chomp call _utils#chomp()

" :EX | chmod +x current buffer
command! EX call _utils#ex()

" :Highlight | find highlight in current context
command! Highlight call _utils#highlight()

" :Root | Change directory to the root of the Git repository
command! Root call _utils#root()

" :CD | cd to current buffer located
command! CD call _utils#cd()


" :NextFile | open next file in 'ls | sort'
command! NextFile :lua require'_utils'.open_nextfile()

" :PrevFile | open previous file in 'ls | sort'
command! PrevFile :lua require'_utils'.open_prevfile()

" :DelMarksAll | clear all marks
command! DelMarksAll :delm! | delm A-Z0-9

" :DiffOrig | Diff with disk
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Sort by selected(visual) column, by Gavin Freeborn
"
" | rr  |  Cool |
" | rgf |     1 |
" | efw |  1200 |
" | ref |  1000 |
" | efa |  1600 |
"
" VisualBlock [1, 1200, 1000, 1600] and :'<,'>SortVis
"
command! -range -nargs=0 -bang SortVis sil! keepj <line1>,<line2>call _utils#VisSort(<bang>0)
xmap s :SortVis<CR>

" :YankPath | copy current path in form of filename:linenr
command! YankPath :lua require'_utils'.yankpath()
nnoremap yp :YankPath<cr>
" }}}

" fzf {{{
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
autocmd  FileType fzf setlocal laststatus=1 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" TODO: reset
" au FileType fzf tnoremap <buffer> <Esc> <c-c>
au FileType fzf tnoremap <buffer> <c-j> <c-j>
au FileType fzf tnoremap <buffer> <c-k> <c-k>

let g:fzf_preview_window = ['right:50%', 'ctrl-/']
" let $FZF_DEFAULT_OPTS = '--inline-info --color "gutter:-1"  '
let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }
" let g:fzf_layout = { 'down': '40%' }
" let g:fzf_layout = { 'window': 'enew' }
let g:fzf_buffers_jump = 1 " [Buffers] Jump to the existing window if possible

" fzf mark with preview
function! s:fzfmarks() abort
  return call('fzf#vim#with_preview', [{'options': '--preview-window +{2}-/2', 'placeholder': '$([ -r $(echo {4} | sed "s#^~#$HOME#") ] && echo {4} || echo ' . fzf#shellescape(expand('%')) . '):{2}'}, 'up:50%', 'ctrl-/'])
endfunction
command! -bar -bang FZFMarks call fzf#vim#marks(s:fzfmarks(), 0)

let g:fzf#proj#project_dir="$HOME/src"
let g:fzf#proj#max_proj_depth=5

packadd fzf
packadd fzf.vim
" packadd fzf-proj.vim

nnoremap <silent><c-f>        :Rgg<cr>
nnoremap <silent><m-f>        :RggWithFile<cr>
nnoremap <silent><Leader>fw   :Rg <C-R><C-W><CR>
nnoremap <silent><Leader>fW   :Rg <C-R><C-A><CR>
vnoremap <silent><Leader>fw   y:Rg <C-R>"<CR>
nnoremap <silent><Leader>fm   :FZFMarks<cr>
nnoremap <silent><leader>fl   :BLines<cr>
nnoremap <silent><leader>ff   :Files<cr>
nnoremap <silent><leader>fh   :History<CR>
nnoremap <silent><leader>'    :FZFMarks<cr>
nnoremap <silent><leader>b    :Buffers<cr>
nnoremap <silent><leader>fC   :Colors<cr>
nnoremap <silent><leader>fc   :Commits<cr>
nnoremap <silent><leader>fp   :Projects<cr>

" }}}

" autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' |  silent OSCYankReg " | endif
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | silent OSCYankReg + | endif

if g:_uname == "linux"
  autocmd InsertLeave * silent call system("fcitx5-remote -c")
end

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
"
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
" imap <C-d> <ESC>:r! date "date +\%Y-\%m-\%d"<CR>kJ$a<cr>
" imap <c-t> [ ] <c-r>=strftime("%Y-%m-%d")<cr> | " todo

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
noremap  <Leader>h :<C-u>split<CR>
noremap  <Leader>v :<C-u>vsplit<CR>
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
    bd!
  else
    q!
  endif
endfunction
inoremap <C-Q>     <esc>:call <sid>close()<cr>
nnoremap <C-Q>     :call <sid>close()<cr>
vnoremap <C-Q>     <esc>:call <sid>close()<cr>

" Save
inoremap <C-s>     <esc>:update<cr>
nnoremap <C-s>     :update<cr>

" https://github.com/mhinz/vim-galore/blob/master/README.md#saner-command-line-history
cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TOGGLE {{{
nnoremap <expr>   <bslash>f &foldlevel ? 'zM' :'zR'
nnoremap <silent> <bslash>w :set wrap!<CR>
nnoremap <silent> <bslash>n :set number! \| set relativenumber!<CR>
nnoremap <silent> <bslash>g :Gitsigns toggle_signs<cr>
nnoremap <silent> <bslash>s
             \ : if exists("syntax_on") <BAR>
             \    syntax off <BAR>
             \ else <BAR>
             \    syntax enable <BAR>
             \ endif<CR>
" }}}

" neoformat {{{
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_lua = ['luafmt']
let g:neoformat_enabled_go = ['gofumports']
packadd neoformat
" }}}

" STARTIFY {{{
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
nnoremap <silent><leader>x :Startify<cr>
" }}}

" nnoremap <silent> gD            <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gD            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gd            <cmd>vsplit<bar>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gt            <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> pd            <cmd>lua vim.lsp.buf.peek_definition()<CR>
nnoremap <silent> g0            <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW            <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

nnoremap <silent> ]d            <cmd>lua vim.lsp.diagnostic.goto_next({wrap = false})<CR>
nnoremap <silent> [d            <cmd>lua vim.lsp.diagnostic.goto_prev({wrap = false})<CR>

nnoremap <silent> ;d            <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> ;dd           <cmd>lua vim.lsp.diagnostic.set_loclist()<cr>
nnoremap <silent> ;r            <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> ;n            <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <silent> ;a            <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <silent> ;a            <cmd>lua vim.lsp.buf.range_code_action()<CR>
nnoremap <silent> ;i            <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> ;f            <cmd>Neoformat<cr>

imap <expr><C-j>                vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-j>'
" inoremap <silent><expr><CR>     compe#confirm('<CR>')

imap <expr><Tab>                v:lua.tab_complete()
smap <expr><Tab>                v:lua.tab_complete()
imap <expr><S-Tab>              v:lua.s_tab_complete()
smap <expr><S-Tab>              v:lua.s_tab_complete()


" let g:indent_blankline_char = '·'
" let g:indent_blankline_space_char = ' '
" let g:indentLine_fileTypeExclude = ['help', 'txt', 'markdown']
" packadd indent-blankline.nvim

" https://github.com/ruifm/gitlinker.nvim
packadd gitlinker.nvim
lua << EOF
require"gitlinker".setup({
  mappings = "gy"
})
EOF

