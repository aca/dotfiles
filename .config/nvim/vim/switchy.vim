" open test (toggle test)
" open _test.go
packadd switchy.vim
nnoremap <silent> <leader>tt :call switchy#switch('edit', 'edit')<CR>
" nnoremap <silent> <leader>tt :packadd switchy.vim \| call switchy#switch('edit', 'edit')<CR>
