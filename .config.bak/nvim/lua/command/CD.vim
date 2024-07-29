" :CD | cd to current buffer located
command! CD call s:cd()
function s:cd()
  execute ":lcd ". expand("%:p:h")
  echon 'pwd: ' . expand("%:p:h")
endfunction
