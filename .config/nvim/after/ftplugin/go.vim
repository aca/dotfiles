packadd vim-goaddtags
packadd nvim-go
packadd gotests-vim 
packadd vim-go-expr-completion

packadd nvim-dap-go
packadd goerr-nvim

setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

nnoremap <silent> ge :<C-u>silent call go#expr#complete()<CR>

autocmd BufWritePre * lua vim.lsp.buf.formatting()
