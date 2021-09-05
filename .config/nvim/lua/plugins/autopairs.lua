vim.cmd [[ 
packadd nvim-autopairs 
]]

require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true -- automatically select the first item
})

require('nvim-autopairs').setup({
  check_ts = true
})
