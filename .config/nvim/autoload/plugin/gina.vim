if exists('g:_minimal') && g:_minimal == v:true | finish | end

packadd gina.vim
cnoreabbrev Git Gina

command! Glog :Gina log -- %:p
command! Agit :packadd agit.vim | :Agit

" gina show always in vsplit
" call gina#custom#command#option(
"         \ '/\%(show\)',
"         \ '--opener', 'vsplit'
"         \)

" gina show close with q
call gina#custom#mapping#nmap(
        \ 'show', 'q',
        \ ':q<CR>',
        \ {'noremap': 1, 'silent': 1},
        \)

call gina#custom#mapping#nmap(
        \ 'log', 'd',
        \ ':execute printf(":new term://git diff %s \| resize +10", gina#action#candidates()[0].rev)<cr>',
        \ {'noremap': 1, 'silent': 1},
        \)

call gina#custom#mapping#nmap(
        \ 'log', 'q',
        \ ':bd<CR>',
        \ {'noremap': 1, 'silent': 1},
        \)

" %domain in the acceptable url pattern list will be substituted into
" 'gitlab.hashnote.net'
" '_' of a url translation scheme dictionary is used as a default
" scheme
" '^' of a url translation scheme dictionary is used as a repository
" scheme
" call extend(g:gina#command#browse#translation_patterns, {
"     \ 'k8s.io': [
"     \   [
"     \     '\vhttps?://(%domain)/(.{-})/(.{-})%(\.git)?$',
"     \     '\vgit://(%domain)/(.{-})/(.{-})%(\.git)?$',
"     \     '\vgit\@(%domain):(.{-})/(.{-})%(\.git)?$',
"     \     '\vssh://git\@(%domain)/(.{-})/(.{-})%(\.git)?$',
"     \   ], {
"     \     'root':  'https://\1/\2/\3/tree/%r1/',
"     \     '_':     'https://\1/\2/\3/blob/%r1/%pt%{#L|}ls%{-}le',
"     \     'exact': 'https://\1/\2/\3/blob/%h1/%pt%{#L|}ls%{-}le',
"     \   },
"     \ ],
"     \})
