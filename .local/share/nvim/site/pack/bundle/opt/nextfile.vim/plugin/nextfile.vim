" vim:foldmethod=marker:fen:
scriptencoding utf-8

" INCLUDE GUARD {{{
if exists('g:loaded_nextfile') && g:loaded_nextfile != 0 | finish | endif
let g:loaded_nextfile = 1
" }}}
" SAVING CPO {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

" GLOBAL VARIABLES {{{
if ! exists('g:nf_map_next')
    let g:nf_map_next = '<Leader>n'
endif
if ! exists('g:nf_map_previous')
    let g:nf_map_previous = '<Leader>p'
endif
if ! exists('g:nf_include_dotfiles')
    let g:nf_include_dotfiles = 0
endif
if ! exists('g:nf_open_command')
    let g:nf_open_command = 'edit'
endif
if ! exists('g:nf_loop_files')
    let g:nf_loop_files = 0
endif
if ! exists('g:nf_loop_hook_fn')
    let g:nf_loop_hook_fn = ''
endif
if ! exists('g:nf_ignore_dir')
    let g:nf_ignore_dir = 1
endif
if ! exists('g:nf_ignore_ext') || type(g:nf_ignore_ext) != type([])
    let g:nf_ignore_ext = []
endif
if ! exists('g:nf_disable_if_empty_name')
    let g:nf_disable_if_empty_name = 0
endif
if ! exists('g:nf_sort_funcref')
    let g:nf_sort_funcref = 'nextfile#compare_by_string'
endif

let s:commands = {
\   'NFLoadGlob' : 'NFLoadGlob',
\ }
if ! exists('g:nf_commands')
    let g:nf_commands = s:commands
else
    call extend(g:nf_commands, s:commands, 'keep')
endif
unlet s:commands
" }}}

" MAPPING {{{
nnoremap <silent> <Plug>(nextfile-next) :<C-u>call nextfile#open_next()<CR>
nnoremap <silent> <Plug>(nextfile-previous) :<C-u>call nextfile#open_previous()<CR>

if g:nf_map_next != ''
    execute 'silent! nmap <silent><unique>' g:nf_map_next '<Plug>(nextfile-next)'
endif
if g:nf_map_previous != ''
    execute 'silent! nmap <silent><unique>' g:nf_map_previous '<Plug>(nextfile-previous)'
endif
" }}}

" COMMANDS {{{
function s:define_commands()
    let command_def = {
    \   'NFLoadGlob' : [
    \       '-complete=file -nargs=+',
    \       'call nextfile#__cmd_load_glob__(<f-args>)'
    \   ]
    \}
    for [cmd, name] in items(g:nf_commands)
        if !empty(name)
            let [opt, def] = command_def[cmd]
            execute printf("command %s %s %s", opt, name, def)
        endif
    endfor
endfunction
call s:define_commands()
delfunction s:define_commands
" }}}

" RESTORE CPO {{{
let &cpo = s:save_cpo
" }}}

