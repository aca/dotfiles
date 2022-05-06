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

" function M.file_type(component, opts)
"     local filetype = bo.filetype
"     local icon
"
"     -- Avoid loading nvim-web-devicons if an icon is provided already
"     if opts.filetype_icon then
"         if not component.icon then
"             local icon_str, icon_color = require('nvim-web-devicons').get_icon_color(
"                 fn.expand('%:t'),
"                 nil, -- extension is already computed by nvim-web-devicons
"                 { default = true }
"             )
"
"             icon = { str = icon_str }
"
"             if opts.colored_icon ~= false then
"                 icon.hl = { fg = icon_color }
"             end
"         end
"
"         filetype = ' ' .. filetype
"     end
"
"     if opts.case == 'titlecase' then
"         filetype = filetype:gsub('%a', string.upper, 1)
"     elseif opts.case ~= 'lowercase' then
"         filetype = filetype:upper()
"     end
"
"     return filetype, icon
" end

set statusline=\ %f%r%h%w%#String#%{NvimGps()}%#StatusLine#%=\ %m\ %-8(%l\ :\ %c%V%)\ %P 
