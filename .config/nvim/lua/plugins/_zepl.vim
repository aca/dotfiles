" finish
" autocmd TermLeave,InsertLeave,BufLeave zepl:* normal! G
" let g:repl_config = {
"             \   'python': {
"             \     'cmd': 'ipython',
"             \     'formatter': function('zepl#contrib#python#formatter')
"             \   }
"             \ }
" lua vim.pack.add({ { src = 'https://github.com/axvr/zepl.vim.git' } })
" runtime zepl/contrib/python.vim  " Enable the Python contrib module.
" runtime zepl/contrib/nvim_autoscroll_hack.vim
