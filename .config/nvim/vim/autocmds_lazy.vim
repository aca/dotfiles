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
