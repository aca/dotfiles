let g:projectionist_heuristics = {}
let g:projectionist_heuristics['*.go'] = {
    \ '*.go': { 'alternate': '{}_test.go', 'type': 'source' },
    \ '*_test.go': { 'alternate': '{}.go', 'type': 'test' }
    \ }

packadd vim-projectionist

if &filetype ==# 'netrw' ? !exists('b:projectionist') :
    \    &buftype !~# 'nofile\|quickfix' |
    \  call ProjectionistDetect(expand('%:p')) |
    \ endif

" if empty(expand('<afile>:p')) |
"     \   call ProjectionistDetect(getcwd()) |
"     \ endif
