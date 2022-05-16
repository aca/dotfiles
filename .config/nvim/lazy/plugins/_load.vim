packadd plenary.nvim
packadd nvim-web-devicons

packadd vim-ReplaceWithRegister
packadd vim-fold-cycle
" packadd clever-f.vim 
packadd vim-fetch " TODO: replace or mv to start
packadd vim-eunuch 
packadd vim-characterize 
packadd fcitx.nvim
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

" plugin: netrw
unlet g:loaded_netrwPlugin
runtime plugin/netrwPlugin.vim

" plugin: matchit
unlet g:loaded_matchit
runtime plugin/matchit.vim
unlet g:loaded_matchparen
runtime plugin/matchparen.vim

" plugin: nextfile
let g:nf_map_next=']f'
let g:nf_map_previous='[f'
packadd nextfile.vim

" plugin: vim-oscyank
packadd vim-oscyank
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is ''  | silent OSCYankReg " | endif
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | silent OSCYankReg + | endif

" plugin: suda.vim
" replace with https://gist.github.com/oessessnex/d63ebe89380abff5a3ee70d6e76e4ec8
packadd suda.vim
command! SudoWrite :SudaWrite
command! SudoRead  :SudaRead

" plugin: https://github.com/bronson/vim-visual-star-search
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

" plugin: vim-swap
let g:swap_no_default_key_mappings = 1
packadd vim-swap
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)

" plugin: vim-move
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

" plugin: codi.vim
command! Codi packadd codi.vim | :Codi

" plugin: luapad
command! Luapad packadd nvim-luapad | :Luapad

packadd vim-boxdraw
