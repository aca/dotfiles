local _g = vim.g
_g.scrollview_on_startup = false
_g.scrollview_winblend = 30
_g.scrollview_base = "left"

-- vim.cmd [[
--   packadd nvim-scrollview
--   autocmd CursorHold * if line('$') > 300 | ScrollViewEnable | endif
-- ]]
