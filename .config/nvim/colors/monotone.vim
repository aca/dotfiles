hi clear
syntax reset

hi Normal        ctermfg=252 ctermbg=233 guifg=#d2cfcf guibg=#121111
hi Visual        ctermfg=16 ctermbg=248 guifg=#121111 guibg=#d2cfcf
hi Cursor        ctermbg=203 guifg=bg guibg=#f54646
hi CursorI       ctermbg=255 guibg=#ffffff
hi CursorR       ctermbg=203 guibg=#f5ac46
hi CursorO       ctermbg=39 guibg=#46bbf5
hi ColorColumn   ctermbg=234 guibg=#171616
" hi CursorLine    ctermbg=234 guibg=#222020
hi! CursorLine     ctermbg=10 guibg=#282a2e
hi CursorLineNr  ctermbg=235 guifg=#9c9695 guibg=#222020
hi Folded        cterm=italic ctermfg=252 ctermbg=235 gui=italic guifg=#d2cfcf guibg=#222020
hi Search        cterm=bold ctermfg=16 ctermbg=214 gui=bold guifg=#121111 guibg=#f5ac46
hi IncSearch     cterm=bold,reverse ctermfg=16 ctermbg=214 gui=bold,reverse guifg=#121111 guibg=#f5ac46
hi LineNr        ctermfg=240 guifg=#5e5959
" hi VertSplit     ctermfg=240 guifg=#5e5959
" hi!  link VertSplit  Normal
hi! VertSplit    guifg=#121111 guibg=#121111 gui=NONE cterm=NONE
hi WildMenu      ctermfg=16 ctermbg=248 guifg=#121111 guibg=#d2cfcf

hi SpecialKey    guifg=NONE     guibg=NONE     gui=bold    ctermfg=NONE  ctermbg=NONE  cterm=bold
hi clear         FoldColumn
hi clear         SignColumn

hi SpecialKey    cterm=bold gui=bold
" hi Error         cterm=bold ctermfg=203 gui=bold guifg=#f54646
" hi ErrorMsg      cterm=bold ctermfg=203 gui=bold guifg=#f54646

hi! Error          ctermfg=0 ctermbg=1 guifg=#1d1f21 guibg=#cc6666
hi! ErrorMsg       ctermfg=1 ctermbg=0 guifg=#cc6666 guibg=#1d1f21
hi Warning       ctermfg=214 guifg=#f5ac46
hi WarningMsg    cterm=bold ctermfg=214 gui=bold guifg=#f5ac46
hi MoreMsg       cterm=bold ctermfg=153 gui=bold guifg=#46bbf5
" hi MatchParen    ctermfg=16 ctermbg=214 guifg=#121111 guibg=#f5ac46
hi MatchParen    gui=underline guibg=NONE
hi link ParenMatch MatchParen
hi Pmenu         ctermfg=246 ctermbg=235 guifg=#787271 guibg=#171616
hi PmenuSbar     ctermbg=235 guibg=#171616
hi PmenuSel      ctermfg=252 ctermbg=235 guifg=#171616 guibg=#9c9695
hi PmenuThumb    ctermbg=235 guibg=#393636
hi TabLine       ctermfg=240 guifg=#5e5959
hi TabLineFill   ctermfg=240 guifg=#5e5959
hi TabLineSel    cterm=bold ctermfg=248 gui=bold guifg=#9c9695
hi Comment       cterm=italic ctermfg=243 gui=italic guifg=#787271
hi String        ctermfg=247 guifg=#9c9695
hi NonText       ctermfg=95 guifg=#9b4a3a
hi Todo          cterm=bold,italic ctermfg=214 gui=bold,italic guifg=#f5ac46
hi Whitespace    ctermfg=236 guifg=#393636


" Font style syntax items
hi Function     guifg=NONE     guibg=NONE  gui=italic       ctermfg=NONE  ctermbg=NONE  cterm=italic
hi Identifier   guifg=NONE     guibg=NONE  gui=italic       ctermfg=NONE  ctermbg=NONE  cterm=italic
hi Include      guifg=NONE     guibg=NONE  gui=italic       ctermfg=NONE  ctermbg=NONE  cterm=italic
hi Keyword      guifg=NONE     guibg=NONE  gui=bold         ctermfg=NONE  ctermbg=NONE  cterm=bold
hi Question     guifg=NONE     guibg=NONE  gui=NONE         ctermfg=NONE  ctermbg=NONE  cterm=NONE
hi Statement    guifg=NONE     guibg=NONE  gui=bold         ctermfg=NONE  ctermbg=NONE  cterm=bold
hi Type         guifg=NONE     guibg=NONE  gui=bold         ctermfg=NONE  ctermbg=NONE  cterm=bold
hi Underlined   guifg=NONE     guibg=NONE  gui=underline    ctermfg=NONE  ctermbg=NONE  cterm=underline
hi Title        guifg=NONE     guibg=NONE  gui=bold         ctermfg=NONE  ctermbg=NONE  cterm=bold

" Diff highlighting
hi DiffAdd     guifg=#88aa77  guibg=NONE  gui=NONE       ctermfg=107  ctermbg=NONE  cterm=NONE
hi DiffDelete  guifg=#aa7766  guibg=NONE  gui=NONE       ctermfg=137  ctermbg=NONE  cterm=NONE
hi DiffChange  guifg=#7788aa  guibg=NONE  gui=NONE       ctermfg=67   ctermbg=NONE  cterm=NONE
hi DiffText    guifg=#7788aa  guibg=NONE  gui=underline  ctermfg=67   ctermbg=NONE  cterm=underline

" Quickfix window (some groups need custom 'winhl')
hi QuickFixLine guibg=#333333
hi QFNormal guibg=#222222
hi QFEndOfBuffer guifg=#222222

" Non-highlighted syntax items
hi clear Conceal
hi clear Constant
hi clear Define
hi clear Directory
hi clear Label
hi clear Number
hi clear Operator
hi clear PreProc
hi clear Special
hi clear Noise

" Plugin-specific highlighting
hi link CursorWordHighlight Underlined
hi link CocHighlightText Underlined

" Highlightedyank
hi link HighlightedyankRegion Warning

hi! StatusLine     gui=italic guibg=#182952 
hi! StatusLineNC   gui=italic guibg=#182952 

" hide ~
hi! EndOfBuffer   guifg=#121111 gui=NONE
