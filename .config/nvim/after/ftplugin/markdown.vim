" vim:ft=vim et sw=2 foldmethod=marker

set nonu
setlocal autoindent 
setlocal tabstop=2 
setlocal shiftwidth=2 
" setlocal textwidth=80 
setlocal formatoptions-=t
setlocal comments=fb:>,fb:*,fb:+,fb:-

" hi link markdownCodeBlock Tag
" hi link markdownCode Tag

set foldexpr=NestedMarkdownFolds()

syntax match todoCheckbox "\[\ \]" conceal cchar=
syntax match todoCheckbox "\[x\]" conceal cchar=

 " convert http://*  [title](http://*)
command MakeLink lua require('_markdown').makelink()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" update date for neuron
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function UpdateMarkdownDate()
"   let save_pos = getpos(".")
"   silent! exe '1,4s/^date: .*/date: '. strftime("%Y-%m-%dT%H:%M")
"   call setpos(".", save_pos)
" endfunction
" autocmd BufWritePost ~/src/zettels/**.md  call UpdateMarkdownDate()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sort todo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd BufWritePre ~/src/zettels/todo.md %!sort


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua require('plugins.due')
packadd vim-table-mode
source ~/.config/nvim/vim/md-img-paste.vim
source ~/.config/nvim/vim/markdown-preview.vim
source ~/.config/nvim/vim/vim-markdown.vim
