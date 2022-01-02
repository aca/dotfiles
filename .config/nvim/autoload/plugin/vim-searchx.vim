" packadd vim-searchx
"
" nnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
" nnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
" xnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
" xnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
" cnoremap ; <Cmd>call searchx#select()<CR>
"
" nnoremap N <Cmd>call searchx#prev()<CR>
" nnoremap n <Cmd>call searchx#next()<CR>
" xnoremap N <Cmd>call searchx#prev()<CR>
" xnoremap n <Cmd>call searchx#next()<CR>
" " nnoremap <C-k> <Cmd>call searchx#prev()<CR>
" " nnoremap <C-j> <Cmd>call searchx#next()<CR>
" " xnoremap <C-k> <Cmd>call searchx#prev()<CR>
" " xnoremap <C-j> <Cmd>call searchx#next()<CR>
" " cnoremap <C-k> <Cmd>call searchx#prev()<CR>
" " cnoremap <C-j> <Cmd>call searchx#next()<CR>
"
" " Clear highlights
" nnoremap <C-l> <Cmd>call searchx#clear()<CR>
"
" let g:searchx = {}
"
" " Auto jump if the recent input matches to any marker.
" let g:searchx.auto_accept = v:true
"
" " Marker characters.
" let g:searchx.markers = split('ABCDEFGHIJKLMNOPQRSTUVWXYZ', '.\zs')
"
" " Convert search pattern.
" function g:searchx.convert(input) abort
"   if a:input !~# '\k'
"     return '\V' .. a:input
"   endif
"   return join(split(a:input, ' '), '.\{-}')
" endfunction
