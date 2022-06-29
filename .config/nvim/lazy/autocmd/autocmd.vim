autocmd TextYankPost * lua vim.highlight.on_yank() 
autocmd QuickFixCmdPost cgetexpr cwindow
autocmd QuickFixCmdPost cgetexpr set ft=qf

" Autoclose terminal without prompt
" autocmd BufWinEnter,WinEnter term://* startinsert
" autocmd BufLeave term://* stopinsert

" if there's no other window but quickfix close vim
au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif

autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen * startinsert
tnoremap <Esc> <C-\><C-n>

au BufWritePre *.go silent lua vim.lsp.buf.code_action({apply=true, filter=function(action) return action.title == 'Organize Imports' end})
