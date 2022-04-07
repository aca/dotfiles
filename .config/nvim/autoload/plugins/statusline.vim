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
  if luaeval("require'nvim-gps'.is_available()")
    let msg = luaeval("require'nvim-gps'.get_location()")
    if msg != "" 
      return msg . ' '
    else
      return ""
    endif
  else
    return ''
  endif
endf

set statusline=%{NvimGps()}%<%f%m%r%h%w%=%-8(%l\ :\ %c%V%)\ %P 
