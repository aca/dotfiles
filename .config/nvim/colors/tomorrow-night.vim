set background=dark
let g:colors_name="tomorrow-night"

" hi link LineNr Comment
" hi link CursorLineNr Comment
" hi Folded guibg=NONE guifg=#8c0809 gui=underline cterm=underline
" hi Foldcolumn guibg=NONE
" hi link VertSplit Comment

" hi! Normal         ctermfg=7 ctermbg=0 guifg=#c5c8c6 guibg=#1d1f21
hi! Normal         ctermfg=7 ctermbg=0 guifg=#c5c8c6 guibg=NONE

hi! Debug          ctermfg=1 guifg=#cc6666
hi! Directory      ctermfg=4 guifg=#81a2be
hi! Error          ctermfg=0 ctermbg=1 guifg=#1d1f21 guibg=#cc6666
hi! ErrorMsg       ctermfg=1 ctermbg=0 guifg=#cc6666 guibg=#1d1f21
hi! Exception      ctermfg=1 guifg=#cc6666
hi! FoldColumn     ctermfg=6 ctermbg=10 guifg=#8abeb7 guibg=#282a2e
hi! Folded         ctermfg=8 ctermbg=10 guifg=#969896 guibg=#282a2e
hi! IncSearch      ctermfg=10 ctermbg=9 guifg=#282a2e guibg=#de935f
hi! Macro          ctermfg=1 guifg=#cc6666
hi! MatchParen     ctermbg=8 guibg=#969896
hi! ModeMsg        cterm=bold ctermfg=2 gui=bold guifg=#b5bd68
hi! MoreMsg        ctermfg=2 gui=bold guifg=#b5bd68
hi! Question       ctermfg=4 gui=bold guifg=#81a2be
hi! Search         ctermfg=10 ctermbg=3 guifg=#282a2e guibg=#f0c674
hi! Substitute     ctermfg=10 ctermbg=3 guifg=#282a2e guibg=#f0c674
hi! SpecialKey     ctermfg=8 guifg=#969896
hi! TooLong        ctermfg=1 guifg=#cc6666
hi! Underlined     cterm=underline ctermfg=1 gui=underline guifg=#cc6666
hi! Visual         ctermbg=11 guibg=#373b41
hi! VisualNOS      ctermfg=1 guifg=#cc6666
hi! WarningMsg     ctermfg=1 guifg=#cc6666
hi! WildMenu       ctermfg=1 ctermbg=11 guifg=#cc6666 guibg=#f0c674
hi! Title          ctermfg=4 guifg=#81a2be
hi! Conceal        ctermfg=4 ctermbg=0 guifg=#81a2be guibg=#1d1f21
hi! Cursor         ctermfg=0 ctermbg=7 guifg=#1d1f21 guibg=#c5c8c6
hi! NonText        ctermfg=8 gui=bold guifg=#969896
hi! LineNr         guibg=NONE ctermbg=NONE gui=italic guifg=#969896 ctermfg=8
hi! CursorLineNr   guibg=NONE ctermbg=NONE gui=italic guifg=#969896 ctermfg=8

hi! GitSignsAdd    guibg=NONE guifg=#109868
hi! GitSignsDelete guibg=NONE guifg=#9A353D
hi! GitSignsChange guibg=NONE guifg=#e0af68

hi! SignColumn     ctermfg=8 ctermbg=10 guifg=#969896 guibg=NONE
" !hi StatusLine     ctermfg=12 ctermbg=11 guifg=#b4b7b4 guibg=#373b41
" !hi StatusLineNC   ctermfg=8 ctermbg=10 guifg=#969896 guibg=#282a2e

hi! StatusLineNC guibg=#282a2e guifg=#7d7d7d gui=NONE
hi! StatusLine guibg=#282a2e guifg=#EDDFEF gui=NONE

" !hi StatusLine guibg=#373b41 guifg=#727072 ctermbg=NONE gui=italic
" !hi StatusLineNC guibg=#282a2e guifg=#727072  ctermbg=NONE gui=italic

" hi! VertSplit      ctermfg=11 ctermbg=11 guifg=#373b41 guibg=#373b41
" hi! VertSplit      guibg=NONE ctermbg=NONE
hi! link VertSplit   Comment
hi! ColorColumn    ctermbg=10 guibg=#282a2e
hi! CursorColumn   ctermbg=10 guibg=#282a2e
hi! CursorLine     ctermbg=10 guibg=#282a2e
" hi! CursorLine     ctermbg=10 guibg=#321325
hi! QuickFixLine   ctermbg=10 guibg=#282a2e
hi! Pmenu          ctermfg=7 ctermbg=10 guifg=#c5c8c6 guibg=#282a2e
hi! PmenuSel       ctermfg=10 ctermbg=7 guifg=#282a2e guibg=#c5c8c6
hi! TabLine        ctermfg=8 ctermbg=10 guifg=#969896 guibg=#282a2e gui=italic
hi! TabLineFill    ctermfg=8 ctermbg=10 guifg=#504746 guibg=#282a2e gui=italic
hi! TabLineSel     ctermfg=2 ctermbg=10 guifg=#b5bd68 guibg=#282a2e gui=italic
hi! Boolean        ctermfg=9 guifg=#de935f
hi! Character      ctermfg=1 guifg=#cc6666
hi! Comment        ctermfg=8 guifg=#969896 gui=italic
hi! Conditional    ctermfg=5 guifg=#b294bb
hi! Constant       ctermfg=9 guifg=#de935f
hi! Define         ctermfg=5 guifg=#b294bb
hi! Delimiter      ctermfg=14 guifg=#a3685a
hi! Float          ctermfg=9 guifg=#de935f
hi! Function       ctermfg=4 guifg=#81a2be
hi! Identifier     ctermfg=1 guifg=#cc6666
hi! Include        ctermfg=4 guifg=#81a2be
hi! Keyword        ctermfg=5 guifg=#b294bb gui=italic
hi! Label          ctermfg=3 guifg=#f0c674
hi! Number         ctermfg=9 guifg=#de935f
hi! Operator       ctermfg=7 guifg=#c5c8c6
hi! PreProc        ctermfg=3 guifg=#f0c674
hi! Repeat         ctermfg=3 guifg=#f0c674
hi! Special        ctermfg=6 guifg=#8abeb7
hi! SpecialChar    ctermfg=14 guifg=#a3685a
hi! Statement      ctermfg=1 gui=italic guifg=#cc6666
hi! StorageClass   ctermfg=3 guifg=#f0c674
hi! String         ctermfg=2 guifg=#b5bd68
hi! Structure      ctermfg=5 guifg=#b294bb
hi! Tag            ctermfg=3 guifg=#f0c674
hi! Todo           ctermfg=3 ctermbg=10 guifg=#f0c674 guibg=#282a2e
hi! Type           ctermfg=3 guifg=#f0c674
hi! Typedef        ctermfg=3 guifg=#f0c674

" hi! DiffAdd      guifg=#b5bd68, guibg=#282a2e
" hi! DiffChange   guifg=#969896, guibg=#282a2e
" hi! DiffDelete   guifg=#cc6666, guibg=#282a2e
" hi! DiffText     guifg=#81a2be, guibg=#282a2e
" hi! DiffAdded    guifg=#b5bd68, guibg=#1d1f21
" hi! DiffFile     guifg=#cc6666, guibg=#1d1f21
" hi! DiffNewFile  guifg=#b5bd68, guibg=#1d1f21
" hi! DiffLine     guifg=#81a2be, guibg=#1d1f21
" hi! DiffRemoved  guifg=#cc6666, guibg=#1d1f21
hi! DiffAdd    guibg=#283B4D guifg=NONE
hi! DiffChange guibg=#283B4D guifg=NONE
hi! DiffDelete guibg=#3C2C3C guifg=#725272 gui=bold
hi! DiffText   guibg=#365069 guifg=NONE


" hi SignifySignAdd    ctermfg=green  guifg=#696969 cterm=NONE guibg=NONE
" hi SignifySignDelete ctermfg=red    guifg=#696969 cterm=NONE guibg=NONE
" hi SignifySignChange ctermfg=yellow guifg=#696969 cterm=NONE guibg=NONE

hi! link LspDiagnosticsDefaultInformation Comment
hi! link LspDiagnosticsDefaultHint Comment
hi! link LspDiagnosticsDefaultError Comment
hi! link LspDiagnosticsDefaultWarning Comment
