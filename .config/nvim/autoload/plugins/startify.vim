if exists('g:_minimal') && g:_minimal == v:true | finish | end

packadd vim-startify

function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_change_to_vcs_root = 1
let g:startify_lists = [
        \ { 'type': 'files'                   , 'header': [' MRU'] }           ,
        \ { 'type': 'dir'                     , 'header': [' MRU '. getcwd()] },
        \ { 'type': 'sessions'                , 'header': [' Sessions'] }      ,
        \ { 'type': 'bookmarks'               , 'header': [' Bookmarks'] }     ,
        \ { 'type': function('s:gitModified') , 'header': [' git modified'] }  ,
        \ { 'type': function('s:gitUntracked'), 'header': [' git untracked'] } ,
        \ { 'type': 'commands'                , 'header': [' Commands'] }      ,
        \ ]
let g:startify_custom_header = ''
nnoremap <silent><leader>x :Startify<cr>

" let g:startify_lists = [
"     \ { 'type': 'dir',       'header': startify#center(['MRU '.getcwd()]) },
"     \ { 'type': 'sessions',  'header': startify#center(['Sessions']) },
"     \ { 'type': 'files',     'header': startify#center(['MRU']) },
"     \ { 'type': 'bookmarks', 'header': startify#center(['Bookmarks']) },
"     \ { 'type': 'commands',  'header': startify#center(['Commands']) },
"     \ ]

