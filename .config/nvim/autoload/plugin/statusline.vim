if exists('g:_minimal') && g:_minimal == v:true | finish | end

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

hi! User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi! User2 ctermfg=007 ctermbg=236 guibg=#111f28 guifg=#FFFFFF gui=italic
hi! User3 ctermfg=236 ctermbg=236 guibg=#303030 
hi! User4 guibg=#303030 guifg=#0e0e0e

set laststatus=2
set statusline=%1*%<%f%m%r%h%w\ %3*\ %{NvimGps()}
set statusline+=%=%4*%v
