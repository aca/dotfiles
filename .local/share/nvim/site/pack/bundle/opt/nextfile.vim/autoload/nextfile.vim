let s:save_cpo = &cpo
set cpo&vim



function! nextfile#open_next() abort
    call s:open_next_file(1)
endfunction

function! nextfile#open_previous() abort
    call s:open_next_file(0)
endfunction


" Get files on a directory of current buffer.
" (NOT FILES ON CURRENT DIRECTORY!)
function! s:get_current_files() abort
    " get files list
    let files = s:glob_list(expand('%:p:h') . '/*')
    if g:nf_include_dotfiles
        let files += s:glob_list(expand('%:p:h') . '/.*')
    endif
    if g:nf_ignore_dir
        call filter(files, '! isdirectory(v:val)')
    endif
    if !filereadable(expand('%'))
        " If current buffer is deleted on filesystem,
        " add it as like it exists (#2).
        let files += [expand('%:p')]
    endif
    for ext in g:nf_ignore_ext
        call filter(files, 'fnamemodify(v:val, ":e") !=# ext')
    endfor

    " Convert to absolute path to make comparison easy.
    call map(files, 'fnamemodify(v:val, ":p")')
    return sort(files, g:nf_sort_funcref)
endfunction

" Get next/previous index number at given file list.
function! s:get_next_idx(files, advance, cnt) abort
    try
        " get current file idx
        let tailed = map(copy(a:files), 'fnamemodify(v:val, ":t")')
        let idx = s:get_idx_of_list(tailed, expand('%:t'))
        " move to next or previous
        let idx = a:advance ? idx + a:cnt : idx - a:cnt
    catch /^not found$/
        " open the first file.
        let idx = 0
    endtry
    return idx
endfunction

function! s:open_next_file(advance) abort
    if g:nf_disable_if_empty_name && expand('%') ==# ''
        call s:warn("current file is empty.")
    endif

    let files = s:get_current_files()
    if empty(files) | return | endif
    let idx   = s:get_next_idx(files, a:advance, v:count1)

    if 0 <= idx && idx < len(files)
        " can access to files[idx]
        execute g:nf_open_command fnameescape(files[idx])
    elseif g:nf_loop_files
        " wrap around
        if idx < 0
            " fortunately VimL supports negative index :)
            let idx = -(abs(idx) % len(files))
            " If you want to access to positive index, uncomment this.
            " if idx != 0
            "     let idx = len(files) + idx
            " endif
        else
            let idx = idx % len(files)
        endif
        if g:nf_loop_hook_fn ==# '' || call(g:nf_loop_hook_fn, [files[idx]])
            execute g:nf_open_command fnameescape(files[idx])
        endif
    else
        call s:warnf('no %s file.', a:advance ? 'next' : 'previous')
    endif
endfunction


function! nextfile#__cmd_load_glob__(...) abort
    let files = []
    for glob_expr in a:000
        " NOTE: load only 'files' currently
        let files += filter(s:glob_list(glob_expr), 'filereadable(v:val)')
    endfor
    " call sort(files, g:nf_sort_funcref)

    let save_pos   = getpos('.')
    let save_bufnr = bufnr('%')
    try
        for f in files
            " XXX: Adding :silent will NOT load anything. (Vim's bug?)
            execute 'edit' f
        endfor
    finally
        call setpos('.', save_pos)
        execute save_bufnr . 'buffer'
    endtry
endfunction


" UTIL FUNCTION {{{

function! s:warn(msg) "abort
    echohl WarningMsg
    echomsg a:msg
    echohl None
endfunction

function! s:warnf(fmt, ...) abort
    call s:warn(call('printf', [a:fmt] + a:000))
endfunction

function! s:get_idx_of_list(lis, elem) abort
    let i = 0
    while i < len(a:lis)
        if a:lis[i] ==# a:elem
            return i
        endif
        let i = i + 1
    endwhile
    throw "not found"
endfunction

function! s:glob_list(expr) abort
    let files = split(glob(a:expr), '\n')
    " get rid of '.' and '..'
    call filter(files, 'fnamemodify(v:val, ":t") !=# "." && fnamemodify(v:val, ":t") !=# ".."')
    return files
endfunction

function! nextfile#compare_by_string(a, b) abort
    let [a, b] = [string(a:a), string(a:b)]
    return a ==# b ? 0 : a > b ? 1 : -1
endfunction

" }}}




let &cpo = s:save_cpo
unlet s:save_cpo
