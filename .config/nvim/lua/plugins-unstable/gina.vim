" packadd gina.vim
" cnoreabbrev Git Gina
"
" command! Glog :Gina log -- %:p
"
" " gina show always in vsplit
" " call gina#custom#command#option(
" "         \ '/\%(show\)',
" "         \ '--opener', 'vsplit'
" "         \)
" "
" call gina#custom#mapping#nmap(
"       \ 'blame', 'j',
"       \ 'j<Plug>(gina-blame-echo)'
"       \)
" call gina#custom#mapping#nmap(
"       \ 'blame', 'k',
"       \ 'k<Plug>(gina-blame-echo)'
"       \)
" call gina#custom#mapping#nmap(
"       \ 'blame', '<c-o>',
"       \ '<Plug>(gina-blame-back)'
"       \)
"
" " gina show close with q
" " call gina#custom#mapping#nmap(
" "         \ 'show', 'q',
" "         \ ':q<CR>',
" "         \ {'noremap': 1, 'silent': 1},
" "         \)
" "
" " call gina#custom#command#option(
" "       \ 'log', '--group', 'log-viewer', '--ext-diff'
" "       \)
"
" call gina#custom#command#alias('branch', 'br')
" " call gina#custom#command#option(
" "       \ '/\%(branch\|changes\|grep\|log\)',
" "       \ '--opener', 'vsplit'
" "       \)
"
" call gina#custom#mapping#nmap(
"         \ 'log', 'd',
"         \ ':execute printf(":new term://git diff %s \| resize +10", gina#action#candidates()[0].rev)<cr>',
"         \ {'noremap': 1, 'silent': 1},
"         \)
"
" " call gina#custom#mapping#nmap(
" "         \ 'log', 'q',
" "         \ ':bd<CR>',
" "         \ {'noremap': 1, 'silent': 1},
" "         \)
