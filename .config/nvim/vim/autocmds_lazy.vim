" Replaced with vim-barbaric
" if executable('fcitx5-remote')
"   autocmd InsertLeave * silent call system("fcitx5-remote -c")
" endif
"
" if filereadable('/usr/local/lib/libInputSourceSwitcher.dylib')
"     autocmd InsertLeave * call libcall('/usr/local/lib/libInputSourceSwitcher.dylib', 'Xkb_Switch_setXkbLayout', 'com.apple.keylayout.ABC')
" endif

" autocmd BufWritePre * lua vim.lsp.buf.formatting()

autocmd TextYankPost * lua vim.highlight.on_yank() 
autocmd QuickFixCmdPost cgetexpr cwindow
autocmd QuickFixCmdPost cgetexpr set ft=qf

" Autoclose terminal without prompt
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" Highlight TODO
autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)

" if there's no other window but quickfix close vim
au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif

autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen * startinsert
tnoremap <Esc> <C-\><C-n>


" " Don't save backups of *.gpg files
" set backupskip+=*.gpg
" " To avoid that parts of the file is saved to .viminfo when yanking or
" " deleting, empty the 'viminfo' option.
" set viminfo=
"
" augroup encrypted
"   au!
"
"   " Disable swap files, and set binary file format before reading the file
"   autocmd BufReadPre,FileReadPre *.gpg
"     \ setlocal noswapfile bin
"   " Decrypt the contents after reading the file, reset binary file format
"   " and run any BufReadPost autocmds matching the file name without the .gpg
"   " extension
"   
"   autocmd BufReadPost,FileReadPost *.gpg
"     \ execute "'[,']!gpg --decrypt --default-recipient-self" |
"     \ setlocal nobin |
"     \ execute "doautocmd BufReadPost " . expand("%:r")
"   " Set binary file format and encrypt the contents before writing the file
"   autocmd BufWritePre,FileWritePre *.gpg
"     \ setlocal bin |
"     \ '[,']!gpg --encrypt --default-recipient-self
"
"   " After writing the file, do an :undo to revert the encryption in the
"   " buffer, and reset binary file format
"   autocmd BufWritePost,FileWritePost *.gpg
"     \ silent u |
"     \ setlocal nobin
"
" augroup END
