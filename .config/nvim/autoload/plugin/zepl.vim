finish
if exists('g:_minimal') && g:_minimal == v:true | finish | end

autocmd TermLeave,InsertLeave,BufLeave zepl:* normal! G
let g:repl_config = {
            \   'python': {
            \     'cmd': 'ipython',
            \     'formatter': function('zepl#contrib#python#formatter')
            \   }
            \ }
packadd zepl.vim
runtime zepl/contrib/python.vim  " Enable the Python contrib module.
runtime zepl/contrib/nvim_autoscroll_hack.vim
