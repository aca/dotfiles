" :Chomp | remove trailing whitespaces
command! Chomp %s/\s\+$// | normal! ``

" :Compact | remove empty
command! Squeeze :g/^\s*$/d
