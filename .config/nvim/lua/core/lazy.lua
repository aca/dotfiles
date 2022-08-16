vim.cmd([[ 
packadd plenary.nvim

packadd fugitive
packadd vim-rhubarb
" packadd gitlinker.nvim
" nnoremap gm :GitMessenger<cr>
" packadd git-messenger.vim

" packadd gv.vim

packadd telescope.nvim
packadd telescope-fzf-native.nvim
packadd telescope-hop.nvim

packadd nvim-web-devicons
packadd vim-ReplaceWithRegister
packadd zen-mode.nvim
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


command! Codi packadd codi.vim | :Codi
command! Luapad packadd nvim-luapad | :Luapad

packadd vim-boxdraw
packadd vim-markdown-toc

packadd aerial.nvim

packadd vim-dadbod
packadd vim-dadbod-ui


packadd FixCursorHold.nvim
" packadd indent-blankline.nvim

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

]])

-- defaults
vim.cmd([[
unlet g:loaded_clipboard_provider
runtime plugin/clipboard.vim
unlet g:loaded_netrwPlugin
runtime plugin/netrwPlugin.vim
unlet g:loaded_matchit
runtime plugin/matchit.vim
unlet g:loaded_matchparen
runtime plugin/matchparen.vim
]])

-- colors
vim.cmd([[
packadd onedark.nvim
packadd zenburn.nvim
]])

-- edit
vim.cmd([[
packadd quickfix-reflector.vim

packadd suda.vim
command! SudoWrite :SudaWrite
command! SudoRead  :SudaRead

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

let g:swap_no_default_key_mappings = 1
packadd vim-swap
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)

packadd Comment.nvim 
runtime after/plugin/Comment.lua
packadd nvim-ts-context-commentstring



]])

-- navigate
vim.cmd([[
let g:nf_map_next=']f'
let g:nf_map_previous='[f'
packadd nextfile.vim

packadd vim-dirvish


packadd fold-cycle.nvim


packadd hop.nvim
]])

vim.cmd [[
imap <silent><c-d> <c-r>=strftime("## %Y-%m-%d %a %H:%M:%S %Z")<cr><cr>
]]
