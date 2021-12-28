if exists('g:_minimal') && g:_minimal == v:true | finish | end

function s:vifm()
  let g:floaterm_opener="edit"
  packadd vim-floaterm
  if expand('%:p') != ""
    FloatermNew --height=0.9 --width=0.9 --title=vifm vifm --select '%:p'
  else
    " FloatermNew --height=0.9 --width=0.9 --title=vifm vifm -c ':vs |:tree! | :view! | set nodotfiles'
    FloatermNew --height=0.9 --width=0.9 --title=vifm vifm
  end
endfunction

command! DiffVifm :packadd vifm.vim | :DiffVifm
nnoremap <silent><c-e> <cmd>call <sid>vifm()<cr>
