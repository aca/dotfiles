packadd plenary.nvim
packadd telescope.nvim
packadd telescope-fzf-native.nvim
packadd telescope-hop.nvim

packadd nvim-web-devicons
" packadd vim-visual-star-search
packadd vim-ReplaceWithRegister
" packadd vim-fold-cycle
packadd fold-cycle.nvim
packadd zen-mode.nvim
" packadd clever-f.vim 
packadd vim-fetch " TODO: replace or mv to start
packadd vim-eunuch 
packadd vim-characterize 
" packadd fcitx.nvim
" packadd vim-rfc 
" packadd symbols-outline.nvim
" packadd vim-diagon
packadd bufferize.vim
packadd vim-scriptease 
packadd diffview.nvim 
" packadd todo-comments.nvim 
packadd nvim-colorizer.lua
" packadd webapi-vim
" packadd vim-gist
packadd fugitive
" packadd gv.vim

unlet g:loaded_clipboard_provider
runtime plugin/clipboard.vim
unlet g:loaded_netrwPlugin
runtime plugin/netrwPlugin.vim
unlet g:loaded_matchit
runtime plugin/matchit.vim
unlet g:loaded_matchparen
runtime plugin/matchparen.vim

let g:nf_map_next=']f'
let g:nf_map_previous='[f'
packadd nextfile.vim

packadd vim-oscyank
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is ''  | silent OSCYankReg " | endif
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | silent OSCYankReg + | endif

packadd suda.vim
command! SudoWrite :SudaWrite
command! SudoRead  :SudaRead

let g:swap_no_default_key_mappings = 1
packadd vim-swap
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)

" vim-move
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

command! Codi packadd codi.vim | :Codi
command! Luapad packadd nvim-luapad | :Luapad

packadd vim-boxdraw
packadd vim-markdown-toc

packadd gitlinker.nvim
packadd aerial.nvim

packadd Comment.nvim 
runtime after/plugin/Comment.lua
packadd nvim-ts-context-commentstring

packadd vim-dadbod
packadd vim-dadbod-ui

" nnoremap gm :GitMessenger<cr>
" packadd git-messenger.vim

packadd hop.nvim

" neoformat
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_typescriptreact = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_lua = ['stylua']
let g:neoformat_enabled_go = ['gofumpt']
let g:neoformat_lua_stylua = {
        \ 'exe': 'stylua',
        \ 'args': ['--indent-type=Spaces', '--indent-width=4' , '--search-parent-directories', '--stdin-filepath', '"%:p"', '--', '-'],
        \ 'stdin': 1,
\ }
packadd neoformat

" tmux
packadd vim-tmux-navigator
nnoremap <silent><c-h> <cmd>TmuxNavigateLeft<cr>
nnoremap <silent><c-j> <cmd>TmuxNavigateDown<cr>
nnoremap <silent><c-k> <cmd>TmuxNavigateUp<cr>
nnoremap <silent><c-l> <cmd>TmuxNavigateRight<cr>
tnoremap <c-h> <C-\><C-N><cmd>TmuxNavigateLeft<cr>
tnoremap <c-j> <C-\><C-N><cmd>TmuxNavigateDown<cr>
tnoremap <c-k> <C-\><C-N><cmd>TmuxNavigateUp<cr>
tnoremap <c-l> <C-\><C-N><cmd>TmuxNavigateRight<cr>

packadd better-vim-tmux-resizer
let g:tmux_resizer_no_mappings = 1
nnoremap <silent> <m-h> <cmd>TmuxResizeLeft<cr>
nnoremap <silent> <m-j> <cmd>TmuxResizeDown<cr>
nnoremap <silent> <m-k> <cmd>TmuxResizeUp<cr>
nnoremap <silent> <m-l> <cmd>TmuxResizeRight<cr>

packadd stabilize.nvim

packadd vim-dirvish
packadd onedark.nvim
packadd zenburn.nvim
packadd FixCursorHold.nvim
" packadd copilot.vim
" packadd indent-blankline.nvim

packadd go.nvim
lua require('go').setup()


" NOTES(aca): neovim visual block does not work as expected, override with this.
" Need to fix https://github.com/neovim/neovim/pull/18538/files
" visualblocking `Created "$WORK/secret.txt.age` does not work
" visualblocking `Created "$WORK/secret.txt.age` does not work
" https://github.com/bronson/vim-visual-star-search/blob/master/plugin/visual-star-search.vim
" makes * and # work on visual mode too.  global function so user mappings can call it.
" specifying 'raw' for the second argument prevents escaping the result for vimgrep
" TODO: there's a bug with raw mode.  since we're using @/ to return an unescaped
" search string, vim's search highlight will be wrong.  Refactor plz.
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

" replace vim's built-in visual * and # behavior
xnoremap * :<C-u>call VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>

" recursively vimgrep for word under cursor or selection
if maparg('<leader>*', 'n') == ''
  nnoremap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
endif
if maparg('<leader>*', 'v') == ''
  vnoremap <leader>* :<C-u>call VisualStarSearchSet('/')<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>
endif

tnoremap <Esc> <C-\><C-n>
