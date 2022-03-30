" set background=light

" colorscheme substrata
" colorscheme raider
" colorscheme monotone
" colorscheme tomorrow-night
colorscheme falcon
" colorscheme seoul256

" hi! link LspDiagnosticsDefaultInformation Comment
" hi! link LspDiagnosticsDefaultHint Comment
" hi! link LspDiagnosticsDefaultError Comment
" hi! link LspDiagnosticsDefaultWarning Comment

hi! link DiagnosticError Comment
hi! link DiagnosticWarn Comment
hi! link DiagnosticInfo Comment
hi! link DiagnosticHint Comment
hi! link DiagnosticUnderlineError Comment
hi! link DiagnosticUnderlineWarn Comment
hi! link DiagnosticUnderlineInfo Comment
hi! link DiagnosticUnderlineHint Comment
hi! link DiagnosticVirtualTextError Comment
hi! link DiagnosticVirtualTextWarn Comment
hi! link DiagnosticVirtualTextInfo Comment
hi! link DiagnosticVirtualTextHint Comment
hi! link DiagnosticFloatingError Comment
hi! link DiagnosticFloatingWarn Comment
hi! link DiagnosticFloatingInfo Comment
hi! link DiagnosticFloatingHint Comment
hi! link DiagnosticSignError Comment
hi! link DiagnosticSignWarn Comment
hi! link DiagnosticSignInfo Comment
hi! link DiagnosticSignHint Comment

hi! DiagnosticError gui=italic
hi! DiagnosticWarn gui=italic
hi! DiagnosticInfo gui=italic
hi! DiagnosticHint gui=italic
hi! DiagnosticUnderlineError gui=italic
hi! DiagnosticUnderlineWarn gui=italic
hi! DiagnosticUnderlineInfo gui=italic
hi! DiagnosticUnderlineHint gui=italic
hi! DiagnosticVirtualTextError gui=italic
hi! DiagnosticVirtualTextWarn gui=italic
hi! DiagnosticVirtualTextInfo gui=italic
hi! DiagnosticVirtualTextHint gui=italic
hi! DiagnosticFloatingError gui=italic
hi! DiagnosticFloatingWarn gui=italic
hi! DiagnosticFloatingInfo gui=italic
hi! DiagnosticFloatingHint gui=italic
hi! DiagnosticSignError gui=italic
hi! DiagnosticSignWarn gui=italic
hi! DiagnosticSignInfo gui=italic
hi! DiagnosticSignHint gui=italic

hi! User1 guifg=#131A1C guibg=#928374
hi! User2 guifg=#928374 guibg=#131A1C gui=none
" set statusline=%1*\ \ \ %2*\ %<%f%m%r%h%w%=%p%%\ %l:%v
set statusline=%1*\ \ %2*\ %<%f%m%r%h%w%=%{mode()}\ %p%%\ %1*\ %l:%v\ 

hi! MsgArea gui=italic guibg=#000000 guifg=#ffffff

