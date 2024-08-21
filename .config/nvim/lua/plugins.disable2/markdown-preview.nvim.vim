
" let $NODE_NO_WARNINGS=1
" let $NODE_OPTIONS = "--no-warnings"
" let g:mkdp_echo_preview_url = 1
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

let g:mkdp_open_to_the_world = 1
let g:mkdp_port = 23222
let g:mkdp_open_ip = '127.0.0.1'
" let g:mkdp_open_ip = '100.82.204.67'
" function! g:Open_browser(url)
"     " echom a:url
"     " silent exe '!ssh rok-toss "bash" "-c" "~/bin/webview-deno 'a:url .. '& "'
"     silent exe '!lemonade open 'a:url
" endfunction
" let g:mkdp_browserfunc = 'g:Open_browser'
" let g:mkdp_browser = 'google-chrome-stable'

function s:markdown_preview()
  packadd markdown-preview.nvim
  " if !isdirectory(stdpath('data') . '/site/pack/paqs/opt/markdown-preview.nvim/app/bin')
  "   silent call mkdp#util#install()
  " end
  silent call system('kill $(pgrep -f markdown-preview)')
  call mkdp#util#open_preview_page()
endfunction

nnoremap <leader>md :call <sid>markdown_preview()<cr>
