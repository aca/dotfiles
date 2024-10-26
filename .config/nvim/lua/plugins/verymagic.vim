
cnoremap %s/ %s/\v
cnoremap s/ s/\v
" https://stackoverflow.com/questions/3760444/in-vim-is-there-a-way-to-set-very-magic-permanently-and-globally
" Since I use incsearch:
" let g:VeryMagic = 0
" nnoremap / /\v
" nnoremap ? ?\v
" vnoremap / /\v
" vnoremap ? ?\v
" " " If I type // or ??, I don't EVER want \v, since I'm repeating the previous
" " " search.
" " noremap // //
" " noremap ?? ??
" " " no-magic searching
" " noremap /v/ /\V
" " noremap ?V? ?\V
"
" " Turn on all other features.
" let g:VeryMagicSubstituteNormalise = 1
" let g:VeryMagicSubstitute = 1
" let g:VeryMagicGlobal = 1
" let g:VeryMagicVimGrep = 1
" let g:VeryMagicSearchArg = 1
" let g:VeryMagicFunction = 1
" let g:VeryMagicHelpgrep = 1
" let g:VeryMagicRange = 1
" let g:VeryMagicEscapeBackslashesInSearchArg = 1
" let g:SortEditArgs = 1
