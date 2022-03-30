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

" func! Fticon() abort
"   let icon = luaeval("require'nvim-web-devicons'.get_icon( vim.bo.filetype)")
"   return icon != v:null? icon: ''
" endf

func! NvimGps() abort
  return luaeval("require'nvim-gps'.is_available()") ?  luaeval("require'nvim-gps'.get_location()") : ''
endf

" comp.separator = left and { right = '' } or { left = '' }

set statusline=%1*\ %{NvimGps()}\ %2*\ %<%f%m%r%h%w%=%{mode()}\ %p%%\ %1*\ %l:%v\ 
