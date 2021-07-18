" vim: foldmethod=marker



" " PAQ {{{
"
" command PaqInstall call <sid>loadPaq() | :PaqInstall
" command PaqSync call <sid>loadPaq() | :PaqSync
" command PaqClean   call <sid>loadPaq() | :PaqClean
" command PaqUpdate  call <sid>loadPaq() | :PaqUpdate
"
" function s:loadPaq()
"         " if empty(glob('~/.local/share/nvim/site/pack/paqs/opt/paq-nvim'))
"         "   silent !git clone https://github.com/savq/paq-nvim.git ~/.local/share/nvim/site/pack/paqs/opt/paq-nvim
"         " endif
"         packadd paq-nvim
"
"         lua << EOF
" EOF
"
" endfunction
" " }}}

" inkarkat/vim-ReplaceWithRegister {{{
" [count]["x]gr{motion}   Replace {motion} text with the contents of register x.
"                         Especially when using the unnamed register, this is
"                         quicker than "_d{motion}P or "_c{motion}<C-R>"
" [count]["x]grr          Replace [count] lines with the contents of register x.
"                         To replace from the cursor position to the end of the
"                         line use ["x]gr$
" {Visual}["x]gr          Replace the selection with the contents of register x.
" nmap <Leader>r  <Plug>ReplaceWithRegisterOperator
" nmap <Leader>rr <Plug>ReplaceWithRegisterLine
" xmap <Leader>r  <Plug>ReplaceWithRegisterVisual
packadd vim-ReplaceWithRegister
" }}}

" machakann/vim-swap {{{
let g:swap_no_default_key_mappings = 1
packadd vim-swap
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
" }}}


packadd diffview.nvim
packadd vim-smoothie
packadd hop.nvim
packadd clever-f.vim
packadd tcomment_vim
packadd vim-fold-cycle
" packadd vim-oscyank
packadd firenvim
" packadd vim-sleuth
packadd pastefix.vim
packadd vim-illuminate
packadd vim-fetch
packadd funcs.nvim
packadd nvim-colorizer.lua
packadd codi.vim

packadd xdg_open.vim
let g:xdg_open_command='xdg-open'
let g:netrw_browsex_viewer='xdg-open'

let test#strategy = "neovim"
packadd vim-test

command! Grammar packadd vim-grammarous | :GrammarousCheck

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

packadd plenary.nvim

lua <<EOF
require '_gitsigns'
require '_dial'
require '_zenmode'
require '_dap'
require '_paq'
EOF

" https://github.com/steelsojka/pears.nvim {{{
" packadd pears.nvim 
" lua require("pears").setup()
" lua require("pears").attach()
" }}}

" zepl.vim {{{
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
packadd nvim-peekup
lua require('nvim-peekup.config').on_keystroke["delay"] = ''
" }}}

" lambdalisue/gina.vim {{{
packadd gina.vim
cnoreabbrev Git Gina
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
" nmap <silent><Leader>w :HopWord<cr>
" }}}

" lambdalisue/suda.vim {{{
command! SudoWrite packadd suda.vim | :SudaWrite
command! SudoRead packadd suda.vim | :SudaRead
" }}}

" https://github.com/rhysd/git-messenger.vim {{{
command! GitMessenger packadd git-messenger.vim | :GitMessenger
nnoremap gm :GitMessenger<cr>
" }}}

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

" https://vi.stackexchange.com/questions/17901/how-to-make-neovim-to-not-show-the-process-exited-num-when-quitting-a-term
" autocmd TermClose * :bd!

au FileType floaterm tnoremap <buffer> <Esc> <c-c>
command! DiffVifm packadd vifm.vim | :DiffVifm
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

" RyanMillerC/better-vim-tmux-resizer {{{
packadd better-vim-tmux-resizer
let g:tmux_resizer_no_mappings = 1
nnoremap <silent> <m-h> <cmd>TmuxResizeLeft<cr>
nnoremap <silent> <m-j> <cmd>TmuxResizeDown<cr>
nnoremap <silent> <m-k> <cmd>TmuxResizeUp<cr>
nnoremap <silent> <m-l> <cmd>TmuxResizeRight<cr>
" }}}

" christoomey/vim-tmux-navigator {{{
packadd vim-tmux-navigator
nnoremap <silent> <c-h> <cmd>TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> <cmd>TmuxNavigateDown<cr>
nnoremap <silent> <c-k> <cmd>TmuxNavigateUp<cr>
nnoremap <silent> <c-l> <cmd>TmuxNavigateRight<cr>

tnoremap <c-h> <C-\><C-N><cmd>TmuxNavigateLeft<cr>
tnoremap <c-j> <C-\><C-N><cmd>TmuxNavigateDown<cr>
tnoremap <c-k> <C-\><C-N><cmd>TmuxNavigateUp<cr>
tnoremap <c-l> <C-\><C-N><cmd>TmuxNavigateRight<cr>
" }}}

" aca/funcs.nvim {{{
xmap s :SortVis<CR>
nnoremap yp :YankPath<cr>
" }}}

" https://github.com/windwp/nvim-autopairs {{{
packadd nvim-autopairs 
lua <<EOF
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true -- it will auto insert `(` after select function or method item
})

require('nvim-autopairs').setup({
  check_ts = true
})
EOF
" }}}

" treesitter {{{
lua <<EOF
if os.getenv("USER") == "rok" then
  require'nvim-treesitter.configs'.setup{
    rainbow = {
      enable = true,
      extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      max_file_lines = 200, -- Do not enable for files with more than 1000 lines, int
    },
    -- ensure_installed = "all",
    ensure_installed = "maintained",
    autopairs = {enable = true},
    highlight = {
      enable = true,
    },
  }
end
EOF
" }}}
