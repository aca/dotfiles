setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

packadd vim-goaddtags
runtime ftplugin/go/goaddtags.vim
" packadd gotests-vim 
" packadd vim-go-expr-completion

" packadd nvim-dap-go
packadd goerr-nvim

packadd vim-go-expr-completion
nnoremap <silent> ge :<C-u>silent call go#expr#complete()<CR>

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
