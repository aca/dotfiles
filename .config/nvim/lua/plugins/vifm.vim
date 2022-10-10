function s:vifm()
  let g:floaterm_opener="edit"
  packadd vim-floaterm
  if expand('%:p') != ""
    let fname = fnameescape(expand('%:p'))
    execute "FloatermNew --height=0.9 --width=0.9 --title=vifm vifm --select " . fname
  else
    " FloatermNew --height=0.9 --width=0.9 --title=vifm vifm -c ':vs |:tree! | :view! | set nodotfiles'
    FloatermNew --height=0.9 --width=0.9 --title=vifm vifm
  end
endfunction
nnoremap <silent><M-e> <cmd>call <sid>vifm()<cr>
