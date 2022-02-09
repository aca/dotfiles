packadd vim-goaddtags
packadd nvim-go
packadd gotests-vim 
packadd vim-go-expr-completion

packadd nvim-dap-go
" packadd goerr-nvim

setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

nnoremap <silent> ge :<C-u>silent call go#expr#complete()<CR>

" TODO fix
autocmd BufWritePre *.go lua require('lsp_run_codeaction')("source.organizeImports", 500); vim.lsp.buf.formatting()

set foldmethod=expr | set foldexpr=nvim_treesitter#foldexpr()
