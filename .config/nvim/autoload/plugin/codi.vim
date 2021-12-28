if exists('g:_minimal') && g:_minimal == v:true | finish | end

command! Codi :packadd codi.vim | :Codi
