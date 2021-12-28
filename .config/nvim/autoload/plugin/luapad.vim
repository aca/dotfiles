if exists('g:_minimal') && g:_minimal == v:true | finish | end

command! Luapad packadd nvim-luapad | :Luapad
