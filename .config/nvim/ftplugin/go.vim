packadd vim-goaddtags
runtime ftplugin/go/goaddtags.vim
" packadd gotests-vim 

" packadd nvim-dap-go
packadd goerr-nvim

packadd vim-go-expr-completion
nnoremap <silent> ge :<C-u>silent call go#expr#complete()<CR>

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua << EOF

local group = vim.api.nvim_create_augroup("go", { clear = false })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*.go",
  callback = function() 
  end
})
EOF
