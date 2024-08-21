let g:floaterm_opener="edit"
let g:floaterm_title=''
packadd vim-floaterm
function s:vifm()
  " if it's directory
  if expand('%:p') != ""
    let fname = escape(shellescape(expand('%:p')), '#')
    execute "FloatermNew --height=0.9 --width=0.9 vifm --select " . fname
    " execute "FloatermNew --height=0.9 --width=0.9 yazi " . fname
  else
    FloatermNew --height=0.9 --width=0.9 --title=vifm vifm -c ':vs |:tree! | :view! | set nodotfiles'
    " FloatermNew --height=0.9 --width=0.9 yazi
    " FloatermNew --height=0.9 --width=0.9 lf
  end
endfunction

nnoremap <silent><C-e> <cmd>call <sid>vifm()<cr>
