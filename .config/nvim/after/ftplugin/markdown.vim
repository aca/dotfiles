" vim:ft=vim et sw=2 foldmethod=marker

setlocal autoindent 
setlocal tabstop=4 
setlocal shiftwidth=4 
setlocal textwidth=82 
setlocal comments=fb:>,fb:*,fb:+,fb:-

" hi link markdownCodeBlock Tag
" hi link markdownCode Tag

" iamcco/markdown-preview.nvim {{{
let g:mkdp_refresh_slow = 1
let g:mkdp_markdown_css = expand('~/src/github.com/edwardtufte/tufte-css/tufte.css')
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
let g:mdip_imgdir = '.image'
nmap <leader>ip :call mdip#MarkdownClipboardImage()<CR>
packadd md-img-paste.vim 
" }}}

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
" packadd vim-markdown

set foldexpr=NestedMarkdownFolds()


packadd vim-table-mode

