let g:mdip_imgdir_absolute = expand("~/src/zettels/static")
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
