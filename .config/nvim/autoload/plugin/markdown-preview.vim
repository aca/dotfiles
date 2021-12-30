if exists('g:_minimal') && g:_minimal == v:true | finish | end

function s:markdown_preview() 

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
