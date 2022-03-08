vim.cmd("packadd LuaSnip")
require("luasnip/loaders/from_vscode").load({ paths = { "~/.local/share/nvim/site/pack/bundle/opt/friendly-snippets" }, })
-- vim.cmd [[
--     runtime! autoload/luasnip/*
-- ]]


-- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1011938524
function _G.leave_snippet()
    if
        ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i') and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()] and not require('luasnip').session.jump_active
    then
        require('luasnip').unlink_current()
    end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_command([[
    autocmd ModeChanged * lua leave_snippet()
]])


require('plugins.luasnip.all')
require('plugins.luasnip.go')
require('plugins.luasnip.markdown')
require('plugins.luasnip.python')
