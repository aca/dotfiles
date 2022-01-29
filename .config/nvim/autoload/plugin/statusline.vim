if exists('g:_minimal') && g:_minimal == v:true | finish | end

packadd nvim-gps
packadd nvim-web-devicons
" packadd vim-devicons

lua <<EOF
require("nvim-gps").setup({
	icons = {
		["class-name"] = 'c:',      -- Classes and class-like objects
		["function-name"] = 'f:',   -- Functions
		["method-name"] = 'm',     -- Methods (functions inside class-like objects)
		["container-name"] = 'c:'   -- Containers (example: lua tables)
	},
	separator = ' > ',
})
EOF


let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

func! Fticon() abort
  let icon = luaeval("require'nvim-web-devicons'.get_icon( vim.bo.filetype)")
  return icon != v:null? icon: ''
endf

func! NvimGps() abort
  let loc = luaeval("require'nvim-gps'.is_available()") ?  luaeval("require'nvim-gps'.get_location()") : ''
  return loc != "" ? loc : '☰'
endf

hi! User1 guifg=#131A1C guibg=#928374
hi! User2 guifg=#928374 guibg=#131A1C gui=none
set laststatus=2
set statusline=%1*\ %{NvimGps()}\ %2*\ %<%f%m%r%h%w%=%p%%\ %l:%v
