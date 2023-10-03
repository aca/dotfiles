vim.g.github_enterprise_urls = {
    "https://git" .. "hub.t" .. "os" .. "sin" .. "ve" .. "st.bz",
}

vim.cmd.packadd 'plenary.nvim'
vim.cmd.packadd 'vim-fugitive'
vim.cmd.packadd 'vim-rhubarb'

-- vim.cmd.packadd 'gv.vim'

vim.cmd.packadd 'tree-sitter-just'

-- vim.cmd.packadd 'telescope.nvim'
-- vim.cmd.packadd "telescope-fzf-native.nvim"
-- vim.cmd.packadd "telescope-hop.nvim"

vim.cmd.packadd 'zen-mode.nvim'
-- vim.cmd.packadd 'clever-f.vim'

vim.cmd([[

" packadd vim-characterize
packadd fcitx.nvim
" packadd vim-rfc
" packadd symbols-outline.nvim
" packadd vim-diagon
" packadd bufferize.vim
packadd vim-scriptease
" packadd diffview.nvim
" packadd nvim-colorizer.lua
" packadd todo-comments.nvim
" packadd webapi-vim
" packadd vim-gist

command! Codi packadd codi.vim | :Codi
command! Luapad packadd nvim-luapad | :Luapad

" packadd vim-boxdraw
" packadd vim-markdown-toc



packadd vim-dirdiff
]])

vim.cmd([[
" NOTES: neovim visual block does not work as expected, override with this.
" Need to fix https://github.com/neovim/neovim/pull/18538/files

" visualblocking `Created "$WORK/secret.txt.age` does not work
" visualblocking `Created "$WORK/secret.txt.age` does not work
" visualblocking `Created "$WORK/se` does not work

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
" xnoremap * y/\V<C-R>"<CR>
]])

-- edit
vim.cmd.packadd 'quickfix-reflector.vim'
vim.cmd.packadd 'vim-ReplaceWithRegister'
vim.cmd.packadd 'vim-eunuch'

vim.cmd([[
" vim-swap
let g:swap_no_default_key_mappings = 1
packadd vim-swap
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
]])

-- navigate
vim.cmd([[
packadd vim-fetch " TODO: replace or mv to start

let g:nf_map_next=']f'
let g:nf_map_previous='[f'
packadd nextfile.vim
packadd vim-dirvish
]])

-- go
vim.cmd.packadd 'go-patch-unusedvar.nvim'
require("go-patch-unusedvar")

-- etc
vim.cmd([[
imap <silent><c-d> <c-r>=strftime("## %Y-%m-%d %a %H:%M:%S %Z")<cr><cr>
]])
