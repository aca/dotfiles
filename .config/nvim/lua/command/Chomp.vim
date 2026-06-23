" :Chomp | remove trailing whitespaces
command! Chomp %s/\s\+$// | normal! ``

" :Squeeze | remove emptyu 
command! Squeeze :g/^\s*$/d
