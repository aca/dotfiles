" vim:ft=vim et sw=2 foldmethod=marker
"
" set textwidth=40
set nowrap

set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
set foldexpr=NestedMarkdownFolds()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_folding_disabled = 1
packadd vim-markdown

packadd due.nvim
lua << EOF
require('due_nvim').setup {
  pattern_start = '-> ',
  pattern_end = '',               -- end for a date string pattern
  fulldate_pattern = '(%d%d%d%d)%-(%d%d)%-(%d%d)'
}
EOF

" set syntax=off

" packadd sniprun
" nmap <leader>R :RunCodeBlock<CR>

" TODO: configure
" let g:bullets_enabled_file_types = [
"     \ 'markdown',
"     \ 'text',
"     \ 'gitcommit',
"     \ 'scratch'
"     \]
" packadd bullets.vim

" packadd vim-table-mode
" packadd vim-pandoc-syntax
hi link pandocCodeblock pandocDelimitedCodeblock

" source ~/.config/nvim/vim/md-img-paste.vim
" source ~/.config/nvim/vim/markdown-preview.vim


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
setlocal tabstop=4 
setlocal shiftwidth=4
" setlocal textwidth=80 
" setlocal formatoptions-=t
setlocal comments=fb:>,fb:*,fb:+,fb:-


 " convert http://*  [title](http://*)
" command FormatLink lua require('scripts.md_format_links').format_link()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" custom syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syn region NeorgConcealURLValue matchgroup=mkdDelimiter start="(" end=")" contained oneline conceal
" syn region NeorgConcealURL matchgroup=mkdDelimiter start="[^\\]\@=\[" skip="\\\]" end="\]\ze(" nextgroup=NeorgConcealURLValue oneline skipwhite concealends
" syn region NeorgConcealURLValue matchgroup=mkdDelimiter start=/(/ end=/)/  contained oneline conceal
" syn region NeorgConcealURL matchgroup=mkdDelimiter start=/\([^\\]\|\_^\)\@<=\[\%\(\%\(\\\=[^\]]\)\+\](\)\@=/ end=/[^\\]\@<=\]/  oneline concealends nextgroup=NeorgConcealURLValue skipwhite
"
" function! s:customSyntax() abort
"   " todo syntax , https://gist.github.com/huytd/668fc018b019fbc49fa1c09101363397
"   syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\s\]'hs=e-4 conceal cchar=
"   syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[X\]'hs=e-4 conceal cchar=
"   " syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[-\]'hs=e-4 conceal cchar=☒
"   " syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\.\]'hs=e-4 conceal cchar=⊡
"   " syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[o\]'hs=e-4 conceal cchar=⬕

function! s:customSyntax() abort
  syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\s\]'hs=e-4 conceal cchar=
  syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[X\]'hs=e-4 conceal cchar=
  syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\@\]'hs=e-4 conceal cchar=➪
  " syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\.\]'hs=e-4 conceal cchar=⊡
  " syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[o\]'hs=e-4 conceal cchar=⬕
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


" Fold expressions {{{1

function! NestedMarkdownFolds()
  let thisline = getline(v:lnum)
  let prevline = getline(v:lnum - 1)
  let nextline = getline(v:lnum + 1)
  if thisline =~ '^```.*$' && prevline =~ '^\s*$'  " start of a fenced block
    return "a1"
  elseif thisline =~ '^```$' && nextline =~ '^\s*$'  " end of a fenced block
    return "s1"
  endif

  let depth = HeadingDepth(v:lnum)
  if depth > 0
    return ">".depth
  else
    return "="
  endif
endfunction

" Helpers {{{1
function! s:SID()
  return matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\zeSID$')
endfunction

function! HeadingDepth(lnum)
  let level=0
  let thisline = getline(a:lnum)
  if thisline =~ '^#\+\s\+'
    let hashCount = len(matchstr(thisline, '^#\{1,6}'))
    if hashCount > 0
      let level = hashCount
    endif
  else
    if thisline != ''
      let nextline = getline(a:lnum + 1)
      if nextline =~ '^=\+\s*$'
        let level = 1
      elseif nextline =~ '^-\+\s*$'
        let level = 2
      endif
    endif
  endif
  if level > 0 && LineIsFenced(a:lnum)
    " Ignore # or === if they appear within fenced code blocks
    let level = 0
  endif
  return level
endfunction

function! LineIsFenced(lnum)
  if exists("b:current_syntax") && b:current_syntax ==# 'markdown'
    " It's cheap to check if the current line has 'markdownCode' syntax group
    return HasSyntaxGroup(a:lnum, '\vmarkdown(Code|Highlight)')
  else
    " Using searchpairpos() is expensive, so only do it if syntax highlighting
    " is not enabled
    return s:HasSurroundingFencemarks(a:lnum)
  endif
endfunction

function! HasSyntaxGroup(lnum, targetGroup)
  let syntaxGroup = map(synstack(a:lnum, 1), 'synIDattr(v:val, "name")')
  for value in syntaxGroup
    if value =~ a:targetGroup
        return 1
    endif
  endfor
endfunction

function! s:HasSurroundingFencemarks(lnum)
  let cursorPosition = [line("."), col(".")]
  call cursor(a:lnum, 1)
  let startFence = '\%^```\|^\n\zs```'
  let endFence = '```\n^$'
  let fenceEndPosition = searchpairpos(startFence,'',endFence,'W')
  call cursor(cursorPosition)
  return fenceEndPosition != [0,0]
endfunction

function! s:FoldText()
  let level = HeadingDepth(v:foldstart)
  let indent = repeat('»', level)
  let title = substitute(getline(v:foldstart), '^#\+\s\+', '', '')
  let foldsize = (v:foldend - v:foldstart)

  " if level < 6
  "   let spaces_1 = repeat(' ', 6 - level)
  " else
  "   let spaces_1 = ' '
  " endif

  if exists('*strdisplaywidth')
      let title_width = strdisplaywidth(title)
  else
      let title_width = len(title)
  endif

  return indent.' '.title
endfunction

setlocal foldmethod=expr
let &l:foldtext = s:SID() . 'FoldText()'
let &l:foldexpr = 'NestedMarkdownFolds()'


packadd markdown-preview.nvim
" " let $NODE_OPTIONS = "--no-warnings"
function s:markdown_preview()
  " let $NODE_NO_WARNINGS=1
  let g:mkdp_echo_preview_url = 1
  "
  " let g:mkdp_refresh_slow = 1
  let g:mkdp_theme = 'dark'
  let g:mkdp_markdown_css = expand('~/.config/nvim/mkdp.css')
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
      \ 'prefers-color-scheme': 'dark',                                          
      \ 'theme': 'dark',                                          
      \ 'disable_filename': 1
      \ }
  packadd markdown-preview.nvim

  if !isdirectory(stdpath('data') . '/site/pack/paqs/opt/markdown-preview.nvim/app/bin')
    silent call mkdp#util#install()
  end
  call mkdp#util#open_preview_page()
endfunction

nnoremap <leader>md :call <sid>markdown_preview()<cr>
