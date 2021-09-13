packadd vim-goaddtags
packadd nvim-go
packadd gotests-vim 
packadd vim-go-expr-completion
setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab foldmethod=syntax

nnoremap <silent> ge :<C-u>silent call go#expr#complete()<CR>