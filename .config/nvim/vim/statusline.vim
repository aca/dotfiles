packadd nvim-gps
packadd nvim-web-devicons
" packadd vim-devicons

lua <<EOF
require("nvim-gps").setup({
	icons = {
		["class-name"] = ' ',      -- Classes and class-like objects
		["function-name"] = ' ',   -- Functions
		["method-name"] = ' ',     -- Methods (functions inside class-like objects)
		["container-name"] = '⛶ '   -- Containers (example: lua tables)
	},
	-- Disable any languages individually over here
	-- Any language not disabled here is enabled by default
	languages = {
	},
	separator = ' > ',
})
EOF

func! NvimGps() abort
  return luaeval("require'nvim-gps'.is_available()") ? luaeval("require'nvim-gps'.get_location()") : ''
endf

func! Fticon() abort
  let icon = luaeval("require'nvim-web-devicons'.get_icon( vim.bo.filetype)")
  return icon != v:null? icon: ''
endf

" status bar colors
" au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
" au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
" hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

" Status line
" default: set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" Status Line Custom
" let g:currentmode={
"     \ 'n'  : 'Normal',
"     \ 'no' : 'Normal·Operator Pending',
"     \ 'v'  : 'Visual',
"     \ 'V'  : 'V·Line',
"     \ '^V' : 'V·Block',
"     \ 's'  : 'Select',
"     \ 'S'  : 'S·Line',
"     \ '^S' : 'S·Block',
"     \ 'i'  : 'Insert',
"     \ 'R'  : 'Replace',
"     \ 'Rv' : 'V·Replace',
"     \ 'c'  : 'Command',
"     \ 'cv' : 'Vim Ex',
"     \ 'ce' : 'Ex',
"     \ 'r'  : 'Prompt',
"     \ 'rm' : 'More',
"     \ 'r?' : 'Confirm',
"     \ '!'  : 'Shell',
"     \ 't'  : 'Terminal'
"     \}

set laststatus=2
" set noshowmode
" set statusline=%2*\ %{WebDevIconsGetFileTypeSymbol()}\ 
" set statusline=%2*\ %{Fticon()}\ 
" set statusline=\ %{WebDevIconsGetFileTypeSymbol()}\ 
set statusline+=%2*%<%f%m%r%h%w\ %3*\ %{NvimGps()}
" set statusline+=\ %{NvimGps()}
set statusline+=%=                                       " Right Side
" set statusline+=%0*\ %n\                                 " Buffer number
set statusline+=%l:%v                 " File path, modified, readonly, helpfile, preview
" set statusline+=\ %<%f%m%r%h%w:%l:%v\                    " File path, modified, readonly, helpfile, preview
" set statusline+=%1*│                                     " Separator
" set statusline+=%3*│                                     " Separator
" set statusline+=%2*\ %Y\                                 " FileType
" set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
" set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
" set statusline+=%2*\%v:%l                         " Colomn number
" set statusline+=%0*\ %{toupper(g:currentmode[mode()])}\  " The current mode

" hi! User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi! User2 ctermfg=007 ctermbg=236 guibg=#111f28 guifg=#FFFFFF gui=italic
hi! User3 ctermfg=236 ctermbg=236 guibg=#303030 
" hi! User4 ctermfg=239 ctermbg=239 guibg=#4e4e4e guifg=#4e4e4e
"
" set statusline=%f\ \ %h%w%m%r\ %=%(%l,%c%V\ %Y\ %=\ %P%)
