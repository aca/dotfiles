function! s:bytes_offset(line, col) abort
  if &encoding !=# 'utf-8'
    let l:sep = "\n"
    if &fileformat ==# 'dos'
      let l:sep = "\r\n"
    elseif &fileformat ==# 'mac'
      let l:sep = "\r"
    endif
    let l:buf = a:line ==# 1 ? '' : (join(getline(1, a:line-1), l:sep) . l:sep)
    let l:buf .= a:col ==# 1 ? '' : getline('.')[:a:col-2]
    return len(iconv(l:buf, &encoding, 'utf-8'))
  endif
  return line2byte(a:line) + (a:col-2)
endfunction

function! s:goremovetags(...) abort
  noau update
  let l:fname = expand('%:p')
  let l:cmd = printf('gomodifytags -file %s -offset %d --clear-tags', shellescape(l:fname), s:bytes_offset(line('.'), col('.')))
  let l:out = system(l:cmd)
  let l:lines = split(substitute(l:out, "\n$", '', ''), '\n')
  if v:shell_error != 0
    echomsg join(l:lines, "\n")
    return
  endif
  let l:view = winsaveview()
  silent! %d _
  call setline(1, l:lines)
  call winrestview(l:view)
endfunction

function! s:goaddtags(...) abort
  noau update
  let l:tags = []
  let l:options = []
  for l:tag in split(a:000[0], '\s\+')
    let l:token = split(l:tag, ',')
    call add(l:tags, l:token[0])
    if len(l:token) == 2
      call add(l:options, l:token[0] . '=' . l:token[1])
    endif
  endfor
  let l:args = ['--add-tags', join(l:tags, ',')]
  if !empty(l:options)
    let l:args += ['--add-options', join(l:options, ' ')]
  endif
  let l:fname = expand('%:p')
  let l:transform = get(g:, 'go_addtags_transform', 'snakecase')
  let l:cmd = printf('gomodifytags -file %s -offset %d -transform %s %s', shellescape(l:fname), s:bytes_offset(line('.'), col('.')), l:transform, join(map(l:args, 'shellescape(v:val)'), ' '))
  let l:out = system(l:cmd)
  let l:lines = split(substitute(l:out, "\n$", '', ''), '\n')
  if v:shell_error != 0
    echomsg join(l:lines, "\n")
    return
  endif
  let l:view = winsaveview()
  silent! %d _
  call setline(1, l:lines)
  call winrestview(l:view)
endfunction

command! -nargs=1 -buffer GoAddTags call s:goaddtags(<f-args>)
command! -nargs=0 -buffer GoRemoveTags call s:goremovetags()
