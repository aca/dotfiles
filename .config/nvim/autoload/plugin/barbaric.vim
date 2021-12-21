let g:barbaric_libxkbswitch = ''
let g:barbaric_fcitx_cmd = 'fcitx5-remote'
if g:_uname == 'macOS'
  let g:barbaric_ime = 'macos'
  let g:barbaric_default = '0'
elseif g:_uname == 'Linux'
  let g:barbaric_ime = 'fcitx'
  let g:barbaric_default = '-c'
end

packadd vim-barbaric
