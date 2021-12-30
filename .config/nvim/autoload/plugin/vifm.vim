if exists('g:_minimal') && g:_minimal == v:true | finish | end

" packadd vifm.vim

function s:vifm()
  let g:floaterm_opener="edit"
  packadd vim-floaterm
  if expand('%:p') != ""
    " FloatermNew --height=0.9 --width=0.9 --title=vifm vifm --select fnameescape('%:p')
    " echom "loaded with dir"
    " echom fnameescape(expand('%:p'))
    " execute "SplitVifm --select " + fnameescape(expand('%:p:h'))
    " echom "vifm --select " . fnameescape(expand('%:p:h'))
    execute "Vifm --select " . fnameescape(expand('%:p:h'))
    " execute "echo " + fnameescape(expand('%:p:h'))
  else
    " echom "loaded with nodir"
    " FloatermNew --height=0.9 --width=0.9 --title=vifm vifm -c ':vs |:tree! | :view! | set nodotfiles'
    Vifm
    " FloatermNew --height=0.9 --width=0.9 --title=vifm vifm
  end
endfunction
"
" command! DiffVifm :packadd vifm.vim | :DiffVifm
nnoremap <silent><c-e> <cmd>call <sid>vifm()<cr>
let g:vifm_embed_split = 1
packadd vifm.vim
" nnoremap <silent><c-e> :execute "SplitVifm --select fnameescape("%:p:h")<cr>
" nnoremap <silent><c-e> :exe ":SplitVifm --select" fnameescape(escape("%:p"))<cr>
