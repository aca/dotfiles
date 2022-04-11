packadd nvim-gps
" packadd vim-devicons

lua <<EOF
require("nvim-gps").setup({
  icons = {
      ["class-name"] = ' ',      -- Classes and class-like objects
      ["function-name"] = ' ',   -- Functions
      ["method-name"] = ' ',     -- Methods (functions inside class-like objects)
      ["container-name"] = '⛶ ',  -- Containers (example: lua tables)
      ["tag-name"] = '炙'         -- Tags (example: html tags)
  },
	separator = ' > ',
})
EOF

func! NvimGps() abort
  if luaeval("require'nvim-gps'.is_available()")
    let msg = luaeval("require'nvim-gps'.get_location()")
    if msg != "" 
      return '  ' . msg
    else
      return ""
    endif
  else
    return ''
  endif
endf

set statusline=%<%f%m%r%h%w%#String#%{NvimGps()}%#StatusLine#%=%-8(%l\ :\ %c%V%)\ %P 
