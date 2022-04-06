packadd nvim-gps
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

func! NvimGps() abort
  return luaeval("require'nvim-gps'.is_available()") ?  luaeval("require'nvim-gps'.get_location()") . ' ' : ''
endf

" set statusline=%{NvimGps()}%<%f%m%r%h%w%=[%{mode()}]\ %p%%\ \ %l:%v\ 

set statusline=%{NvimGps()}%<%f%m%r%h%w%=%-8(%l\ :\ %c%V%)\ %P 
