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

" iamcco/markdown-preview.nvim {{{
let g:mkdp_theme = 'dark'
let g:mkdp_refresh_slow = 1
" let g:mkdp_markdown_css = expand('~/src/github.com/edwardtufte/tufte-css/tufte.css')
" let g:mkdp_markdown_css = expand('~/src/github.com/otsaloma/markdown-css/tufte.css.orig')
" let g:mkdp_markdown_css = expand('~/src/github.com/otsaloma/markdown-css/tufte.css')
let g:mkdp_auto_close = 0
let g:mkdp_command_for_global = 1
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'disable_filename': 1
    \ }

nnoremap <silent><leader>md :silent! call mkdp#util#open_preview_page()<cr>
let $NODE_NO_WARNINGS=1
packadd markdown-preview.nvim
" }}}

" ferrine/md-img-paste.vim {{{
let g:mdip_imgdir_absolute = expand("~/src/zettels/static")
" let g:mdip_imgdir_intext = "./static"
" nmap <silent><leader>ip :call mdip#MarkdownClipboardImage()<CR><esc>:s#<c-r>=expand("~/src/zettels/image")<cr>#\~/src/zettels/image<cr>
" nmap <silent><leader>ip :call mdip#MarkdownClipboardImage()<CR>
function s:img_paste()
  call mdip#MarkdownClipboardImage()
  let pwd = expand('%:p:h')
  let ans = systemlist("realpath --relative-to " . pwd . ' ' . g:mdip_imgdir_absolute)[0]
  call setline(line('.'), substitute(getline('.'), g:mdip_imgdir_absolute, ans, ''))
endfunction
nmap <leader>ip <cmd>call <sid>img_paste()<cr>
packadd md-img-paste.vim 
" }}}

" https://github.com/plasticboy/vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
packadd vim-markdown
" }}}

set foldexpr=NestedMarkdownFolds()

syntax match todoCheckbox "\[\ \]" conceal cchar=
syntax match todoCheckbox "\[x\]" conceal cchar=

packadd vim-table-mode

 " convert http://*  [title](http://*)
command MakeLink lua require('_markdown').makelink()

" update date for neuron
function UpdateMarkdownDate()
  let save_pos = getpos(".")
  silent! exe '1,4s/^date: .*/date: '. strftime("%Y-%m-%dT%H:%M")
  call setpos(".", save_pos)
endfunction
autocmd BufWritePost ~/src/zettels/**.md  call UpdateMarkdownDate()

packadd due.nvim
lua <<EOF
require('due_nvim').setup {
  pattern_start= ' ',
  pattern_end= ' ',
  }
EOF

autocmd BufWritePre ~/src/zettels/todo.md %!sort
