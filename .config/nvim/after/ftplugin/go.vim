packadd vim-goaddtags
packadd nvim-go
packadd gotests-vim 
packadd switchy.vim
packadd vim-go-expr-completion
setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab foldmethod=syntax

" open _test.go
nnoremap <silent> <leader>tt :call switchy#switch('edit', 'edit')<CR>

nnoremap <silent> ge :<C-u>silent call go#expr#complete()<CR>