" " :DelMarksAll | clear all marks
" command! DelMarksAll :delm! | delm A-Z0-9
"
" " https://vi.stackexchange.com/questions/13984/how-do-i-delete-a-mark-in-current-line
" command! Delmarks silent execute 'delmarks '.join(map(filter(filter(map(split(execute('marks'),"\n"),'split(v:val)'), 'v:val[1]==line(".")&&v:val[0]!~#"[A-Z]"'), 'v:val[1]==line(".")&&v:val[0]!~#"[A-Z]"'), 'v:val[0]'))
"
" function! Delmarks()
"     let l:m = join(filter(
"        \ map(range(char2nr('a'), char2nr('z')), 'nr2char(v:val)'),
"        \ 'line("''".v:val) == line(".")'))
"     if !empty(l:m)
"         exe 'delmarks' l:m
"     endif
" endfunction
" nnoremap <silent> dm :<c-u>call Delmarks()<cr>
