" vim:ft=vim et sw=2 foldmethod=marker

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

packadd sniprun
" nmap <leader>R :RunCodeBlock<CR>


lua require('plugins.due')

" TODO: configure
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \]
packadd bullets.vim



packadd vim-table-mode
packadd vim-pandoc-syntax
hi link pandocCodeblock pandocDelimitedCodeblock

source ~/.config/nvim/vim/md-img-paste.vim
source ~/.config/nvim/vim/markdown-preview.vim


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" etc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

hi link markdownCodeBlock markdownCode

imap <silent><c-d> <c-r>=strftime("## %Y-%m-%d %a %H:%M:%S %Z")<cr><cr>

setlocal laststatus=0
setlocal signcolumn=no
" setlocal cole=1
setlocal nonu
setlocal norelativenumber
setlocal autoindent 
setlocal tabstop=2 
setlocal shiftwidth=2 
" setlocal textwidth=80 
setlocal formatoptions-=t
setlocal comments=fb:>,fb:*,fb:+,fb:-

set foldexpr=NestedMarkdownFolds()

 " convert http://*  [title](http://*)
command FormatLink lua require('scripts.md_format_links').format_link()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" custom syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:customSyntax() abort
  " todo syntax , https://gist.github.com/huytd/668fc018b019fbc49fa1c09101363397
  syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\s\]'hs=e-4 conceal cchar=
  syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[X\]'hs=e-4 conceal cchar=
  syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[-\]'hs=e-4 conceal cchar=☒
  syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\.\]'hs=e-4 conceal cchar=⊡
  syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[o\]'hs=e-4 conceal cchar=⬕
endfunction

autocmd Syntax * call s:customSyntax()

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

command! MakeLink lua require'_markdown'.makelink()



