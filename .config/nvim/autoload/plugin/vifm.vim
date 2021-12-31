if exists('g:_minimal') && g:_minimal == v:true | finish | end

" let g:vifm_embed_split = 1
packadd vifm.vim

function s:vifm()
  let g:vifm_exec_args = "--select " . fnameescape(expand('%:p'))
  Vifm

  " let g:floaterm_opener="edit"
  " packadd vim-floaterm
  " if expand('%:p') != ""
  "   FloatermNew --height=0.9 --width=0.9 --title=vifm vifm --select fnameescape('%:p')
  " else
  "   FloatermNew --height=0.9 --width=0.9 --title=vifm vifm -c ':vs |:tree! | :view! | set nodotfiles'
  "   FloatermNew --height=0.9 --width=0.9 --title=vifm vifm
  " end
endfunction
nnoremap <silent><c-e> <cmd>call <sid>vifm()<cr>
