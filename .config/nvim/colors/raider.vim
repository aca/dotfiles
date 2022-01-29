" Name:        raider.vim
" Author:      Alex Vear <alex@vear.uk>
" Webpage:     https://github.com/axvr/raider.vim
" Description: A Vim colour scheme for archaeological escapades.
" Licence:     MIT (2021)
" Last Change: 2022-01-20
" Generator:   Modified version of RNB (https://github.com/romainl/vim-rnb)

hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "raider"

if ($TERM =~ '256' || &t_Co >= 256) || has("gui_running")
    hi Normal ctermbg=235 ctermfg=251 cterm=NONE guibg=#222222 guifg=#C9C9C9 gui=NONE

    set background=dark

    hi NonText ctermbg=bg ctermfg=239 cterm=NONE guibg=bg guifg=#4A4A4A gui=NONE
    hi Comment ctermbg=bg ctermfg=242 cterm=NONE guibg=bg guifg=#666967 gui=NONE
    hi Constant ctermbg=bg ctermfg=95 cterm=NONE guibg=bg guifg=#88766F gui=NONE
    hi String ctermbg=bg ctermfg=110 cterm=NONE guibg=bg guifg=#94BACA gui=NONE
    hi Identifier ctermbg=bg ctermfg=109 cterm=NONE guibg=bg guifg=#96A8A1 gui=NONE
    hi Statement ctermbg=bg ctermfg=137 cterm=NONE guibg=bg guifg=#998B70 gui=NONE
    hi Exception ctermbg=bg ctermfg=131 cterm=NONE guibg=bg guifg=#A74F4F gui=NONE
    hi Keyword ctermbg=bg ctermfg=103 cterm=NONE guibg=bg guifg=#858CA6 gui=NONE
    hi Operator ctermbg=bg ctermfg=251 cterm=NONE guibg=bg guifg=#C9C9C9 gui=NONE
    hi PreProc ctermbg=bg ctermfg=95 cterm=NONE guibg=bg guifg=#88766F gui=NONE
    hi Include ctermbg=bg ctermfg=95 cterm=NONE guibg=bg guifg=#88766F gui=NONE
    hi Macro ctermbg=bg ctermfg=95 cterm=NONE guibg=bg guifg=#88766F gui=NONE
    hi Define ctermbg=bg ctermfg=137 cterm=NONE guibg=bg guifg=#998B70 gui=NONE
    hi Type ctermbg=bg ctermfg=103 cterm=NONE guibg=bg guifg=#858CA6 gui=NONE
    hi Special ctermbg=bg ctermfg=242 cterm=NONE guibg=bg guifg=#666967 gui=NONE
    hi Error ctermbg=NONE ctermfg=131 cterm=bold guibg=NONE guifg=#A74F4F gui=bold
    hi Warning ctermbg=NONE ctermfg=179 cterm=bold guibg=NONE guifg=#EAB56B gui=bold
    hi ModeMsg ctermbg=NONE ctermfg=110 cterm=NONE guibg=NONE guifg=#94BACA gui=NONE
    hi Todo ctermbg=NONE ctermfg=72 cterm=bold guibg=NONE guifg=#679D80 gui=bold
    hi Underlined ctermbg=NONE ctermfg=251 cterm=underline guibg=NONE guifg=#C9C9C9 gui=underline
    hi StatusLine ctermbg=237 ctermfg=137 cterm=NONE guibg=#343434 guifg=#998B70 gui=NONE
    hi StatusLineNC ctermbg=238 ctermfg=242 cterm=NONE guibg=#2A2A2A guifg=#666967 gui=NONE
    hi WildMenu ctermbg=238 ctermfg=179 cterm=NONE guibg=#2A2A2A guifg=#EAB56B gui=NONE
    hi VertSplit ctermbg=238 ctermfg=238 cterm=NONE guibg=#2A2A2A guifg=#2A2A2A gui=NONE
    hi Title ctermbg=NONE ctermfg=137 cterm=bold guibg=NONE guifg=#998B70 gui=bold
    hi LineNr ctermbg=NONE ctermfg=242 cterm=NONE guibg=NONE guifg=#666967 gui=NONE
    hi CursorLineNr ctermbg=238 ctermfg=179 cterm=NONE guibg=#2A2A2A guifg=#EAB56B gui=NONE
    hi Cursor ctermbg=251 ctermfg=235 cterm=NONE guibg=#C9C9C9 guifg=#222222 gui=NONE
    hi CursorLine ctermbg=238 ctermfg=NONE cterm=NONE guibg=#2A2A2A guifg=NONE gui=NONE
    hi ColorColumn ctermbg=234 ctermfg=NONE cterm=NONE guibg=#1A1A1A guifg=NONE gui=NONE
    hi SignColumn ctermbg=NONE ctermfg=242 cterm=NONE guibg=NONE guifg=#666967 gui=NONE
    hi Visual ctermbg=237 ctermfg=NONE cterm=NONE guibg=#343434 guifg=NONE gui=NONE
    hi VisualNOS ctermbg=237 ctermfg=NONE cterm=NONE guibg=#343434 guifg=NONE gui=NONE
    hi Pmenu ctermbg=238 ctermfg=NONE cterm=NONE guibg=#2A2A2A guifg=NONE gui=NONE
    hi PmenuSbar ctermbg=237 ctermfg=NONE cterm=NONE guibg=#343434 guifg=NONE gui=NONE
    hi PmenuSel ctermbg=237 ctermfg=137 cterm=NONE guibg=#343434 guifg=#998B70 gui=NONE
    hi PmenuThumb ctermbg=110 ctermfg=NONE cterm=NONE guibg=#94BACA guifg=NONE gui=NONE
    hi FoldColumn ctermbg=NONE ctermfg=238 cterm=NONE guibg=NONE guifg=#2A2A2A gui=NONE
    hi Folded ctermbg=234 ctermfg=242 cterm=NONE guibg=#1A1A1A guifg=#666967 gui=NONE
    hi SpecialKey ctermbg=NONE ctermfg=137 cterm=NONE guibg=NONE guifg=#998B70 gui=NONE
    hi IncSearch ctermbg=179 ctermfg=235 cterm=NONE guibg=#EAB56B guifg=#222222 gui=NONE
    hi Search ctermbg=137 ctermfg=235 cterm=NONE guibg=#998B70 guifg=#222222 gui=NONE
    hi Directory ctermbg=NONE ctermfg=110 cterm=NONE guibg=NONE guifg=#94BACA gui=NONE
    hi MatchParen ctermbg=NONE ctermfg=179 cterm=bold guibg=NONE guifg=#EAB56B gui=bold
    hi SpellBad ctermbg=NONE ctermfg=131 cterm=underline guibg=NONE guifg=#A74F4F gui=underline
    hi SpellCap ctermbg=NONE ctermfg=72 cterm=underline guibg=NONE guifg=#679D80 gui=underline
    hi SpellLocal ctermbg=NONE ctermfg=179 cterm=underline guibg=NONE guifg=#EAB56B gui=underline
    hi QuickFixLine ctermbg=234 ctermfg=NONE cterm=NONE guibg=#1A1A1A guifg=NONE gui=NONE
    hi DiffAdd ctermbg=238 ctermfg=72 cterm=NONE guibg=#2A2A2A guifg=#679D80 gui=NONE
    hi DiffChange ctermbg=238 ctermfg=NONE cterm=NONE guibg=#2A2A2A guifg=NONE gui=NONE
    hi DiffDelete ctermbg=238 ctermfg=131 cterm=NONE guibg=#2A2A2A guifg=#A74F4F gui=NONE
    hi DiffText ctermbg=238 ctermfg=179 cterm=NONE guibg=#2A2A2A guifg=#EAB56B gui=NONE
    hi helpHyperTextJump ctermbg=bg ctermfg=110 cterm=NONE guibg=bg guifg=#94BACA gui=NONE

elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
    set t_Co=16

    hi Normal ctermbg=black ctermfg=white cterm=NONE

    set background=dark

    hi NonText ctermbg=bg ctermfg=darkgrey cterm=NONE
    hi Comment ctermbg=bg ctermfg=grey cterm=NONE
    hi Constant ctermbg=bg ctermfg=darkyellow cterm=NONE
    hi String ctermbg=bg ctermfg=blue cterm=NONE
    hi Identifier ctermbg=bg ctermfg=darkgreen cterm=NONE
    hi Statement ctermbg=bg ctermfg=darkyellow cterm=NONE
    hi Exception ctermbg=bg ctermfg=red cterm=NONE
    hi Keyword ctermbg=bg ctermfg=darkblue cterm=NONE
    hi Operator ctermbg=bg ctermfg=white cterm=NONE
    hi PreProc ctermbg=bg ctermfg=darkyellow cterm=NONE
    hi Include ctermbg=bg ctermfg=darkyellow cterm=NONE
    hi Macro ctermbg=bg ctermfg=darkyellow cterm=NONE
    hi Define ctermbg=bg ctermfg=darkyellow cterm=NONE
    hi Type ctermbg=bg ctermfg=darkblue cterm=NONE
    hi Special ctermbg=bg ctermfg=grey cterm=NONE
    hi Error ctermbg=NONE ctermfg=red cterm=bold
    hi Warning ctermbg=NONE ctermfg=yellow cterm=bold
    hi ModeMsg ctermbg=NONE ctermfg=blue cterm=NONE
    hi Todo ctermbg=NONE ctermfg=green cterm=bold
    hi Underlined ctermbg=NONE ctermfg=white cterm=underline
    hi StatusLine ctermbg=darkgrey ctermfg=darkyellow cterm=NONE
    hi StatusLineNC ctermbg=darkgrey ctermfg=grey cterm=NONE
    hi WildMenu ctermbg=darkgrey ctermfg=yellow cterm=NONE
    hi VertSplit ctermbg=darkgrey ctermfg=darkgrey cterm=NONE
    hi Title ctermbg=NONE ctermfg=darkyellow cterm=bold
    hi LineNr ctermbg=NONE ctermfg=grey cterm=NONE
    hi CursorLineNr ctermbg=darkgrey ctermfg=yellow cterm=NONE
    hi Cursor ctermbg=white ctermfg=black cterm=NONE
    hi CursorLine ctermbg=darkgrey ctermfg=NONE cterm=NONE
    hi ColorColumn ctermbg=darkgrey ctermfg=NONE cterm=NONE
    hi SignColumn ctermbg=NONE ctermfg=grey cterm=NONE
    hi Visual ctermbg=darkgrey ctermfg=NONE cterm=NONE
    hi VisualNOS ctermbg=darkgrey ctermfg=NONE cterm=NONE
    hi Pmenu ctermbg=darkgrey ctermfg=NONE cterm=NONE
    hi PmenuSbar ctermbg=darkgrey ctermfg=NONE cterm=NONE
    hi PmenuSel ctermbg=darkgrey ctermfg=darkyellow cterm=NONE
    hi PmenuThumb ctermbg=blue ctermfg=NONE cterm=NONE
    hi FoldColumn ctermbg=NONE ctermfg=darkgrey cterm=NONE
    hi Folded ctermbg=darkgrey ctermfg=grey cterm=NONE
    hi SpecialKey ctermbg=NONE ctermfg=darkyellow cterm=NONE
    hi IncSearch ctermbg=yellow ctermfg=black cterm=NONE
    hi Search ctermbg=darkyellow ctermfg=black cterm=NONE
    hi Directory ctermbg=NONE ctermfg=blue cterm=NONE
    hi MatchParen ctermbg=NONE ctermfg=yellow cterm=bold
    hi SpellBad ctermbg=NONE ctermfg=red cterm=underline
    hi SpellCap ctermbg=NONE ctermfg=green cterm=underline
    hi SpellLocal ctermbg=NONE ctermfg=yellow cterm=underline
    hi QuickFixLine ctermbg=darkgrey ctermfg=NONE cterm=NONE
    hi DiffAdd ctermbg=darkgrey ctermfg=green cterm=NONE
    hi DiffChange ctermbg=darkgrey ctermfg=NONE cterm=NONE
    hi DiffDelete ctermbg=darkgrey ctermfg=red cterm=NONE
    hi DiffText ctermbg=darkgrey ctermfg=yellow cterm=NONE
    hi helpHyperTextJump ctermbg=bg ctermfg=blue cterm=NONE
endif

hi! link Conceal NonText
hi! link Character Constant
hi! link Number Constant
hi! link Float Number
hi! link Boolean Constant
hi! link Function Identifier
hi! link Conditonal Statement
hi! link Repeat Statement
hi! link Label Statement
hi! link PreCondit Define
hi! link StorageClass Type
hi! link Structure Type
hi! link Typedef Type
hi! link SpecialChar Special
hi! link Tag Special
hi! link Delimiter Special
hi! link SpecialComment Special
hi! link Debug Special
hi! link ErrorMsg Error
hi! link WarningMsg Warning
hi! link MoreMsg ModeMsg
hi! link Question ModeMsg
hi! link Ignore NonText
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link TabLine StatusLineNC
hi! link TabLineFill StatusLineNC
hi! link TabLineSel StatusLine
hi! link CursorColumn CursorLine
hi! link SpellRare SpellLocal
hi! link diffAdded DiffAdd
hi! link diffRemoved DiffDelete
hi! link htmlTag Delimiter
hi! link htmlEndTag htmlTag
hi! link gitcommitSummary Title

if (has('termguicolors') && &termguicolors) || has('gui_running')
    if has('nvim')
        let g:terminal_color_0 = '#222222'
        let g:terminal_color_1 = '#A74F4F'
        let g:terminal_color_2 = '#679D80'
        let g:terminal_color_3 = '#998B70'
        let g:terminal_color_4 = '#3465a4'
        let g:terminal_color_5 = '#75507b'
        let g:terminal_color_6 = '#29acc1'
        let g:terminal_color_7 = '#666967'
        let g:terminal_color_8 = '#2A2A2A'
        let g:terminal_color_9 = '#c61c29'
        let g:terminal_color_10 = '#2bb469'
        let g:terminal_color_11 = '#EAB56B'
        let g:terminal_color_12 = '#94BACA'
        let g:terminal_color_13 = '#c061cb'
        let g:terminal_color_14 = '#34e2e2'
        let g:terminal_color_15 = '#C9C9C9'
    else
        let g:terminal_ansi_colors = [
                \ '#222222',
                \ '#A74F4F',
                \ '#679D80',
                \ '#998B70',
                \ '#3465a4',
                \ '#75507b',
                \ '#29acc1',
                \ '#666967',
                \ '#2A2A2A',
                \ '#c61c29',
                \ '#2bb469',
                \ '#EAB56B',
                \ '#94BACA',
                \ '#c061cb',
                \ '#34e2e2',
                \ '#C9C9C9',
                \ ]
    endif
endif
