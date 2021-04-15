packadd vim-goaddtags
packadd nvim-go
packadd gotests-vim 
packadd switchy.vim
setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab foldmethod=syntax

" open _test.go
nnoremap <silent> <leader>tt :call switchy#switch('edit', 'edit')<CR>