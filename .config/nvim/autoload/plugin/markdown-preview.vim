if exists('g:_minimal') && g:_minimal == v:true | finish | end

" function! MKDP_browserfunc_default(url)
"     if has("win32") || has("win64")
"         " windows
"         execute "silent !cmd /c start " . a:url . '.html'
"     elseif has("unix")
"         silent! let s:uname=system("uname")
"         if s:uname=="Darwin\n"
"             " mac
"             let dummy = system('open -a "Brave Browser" -n --args --incognito --new-window "' . a:url . '"')
"         else
"             " unix
"             let dummy = system('xdg-open "' . a:url . '"')
"         endif
"     endif
" endfunction
" if !exists('g:mkdp_browserfunc')
"     let g:mkdp_browserfunc='MKDP_browserfunc_default'
" endif


function s:markdown_preview() 
  " let g:mkdp_browser = 'min -F'
  let $NODE_NO_WARNINGS=1

  " let g:mkdp_theme = 'light'
  " let g:mkdp_refresh_slow = 1
  " let g:mkdp_markdown_css = expand('~/src/github.com/edwardtufte/tufte-css/tufte.css')
  let g:mkdp_markdown_css = expand('~/.config/nvim/tufte.css')
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
  packadd markdown-preview.nvim

  if !isdirectory(stdpath('data') . '/site/pack/paqs/opt/markdown-preview.nvim/app/bin')
    silent call mkdp#util#install()
  end
  call mkdp#util#open_preview_page()
endfunction

nnoremap <silent><leader>md :call <sid>markdown_preview()<cr>
