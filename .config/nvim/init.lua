-- [[
-- vim setup
-- ]]

-- debug

vim.lsp.set_log_level("debug")

require "impatient"

vim.cmd [[
  source ~/.config/nvim/vim/init.vim
]]

require 'autocmds'

local timer = vim.loop.new_timer()

timer:start(0, 0, vim.schedule_wrap(
function()
  vim.cmd [[
    source ~/.config/nvim/lazy.vim
  ]]
end
))
