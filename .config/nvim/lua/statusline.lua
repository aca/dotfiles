_statusline = {}

vim.cmd [[ packadd nvim-gps ]]

local nvim_gps = require('nvim-gps')
nvim_gps.setup({
	disable_icons = true,
	separator = ' > ',
})

_statusline.nvim_gps = function()
  local location = ''
  if nvim_gps.is_available() then
    location = nvim_gps.get_location()
  end
  if location ~= '' then
    return '> ' .. location
  else
    return ''
  end
end

-- vim.o.statusline = "%f %{%v:lua._statusline.nvim_gps()%}%= %m%r%h%w %-8(%l : %c%) %P"
vim.o.statusline = "%=%m%r%h%w %-8(%l : %c%) %P"
vim.o.winbar = "%=%m%f %{%v:lua._statusline.nvim_gps()%}"
