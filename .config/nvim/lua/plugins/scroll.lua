-- https://github.com/petertriho/nvim-scrollbar
vim.cmd [[
   packadd nvim-hlslens
   packadd nvim-scrollbar
]]

require("scrollbar").setup()

require('hlslens').setup({
    calm_down = true,
    nearest_only = true,
    nearest_float_when = 'always',
    override_lens = function(render, posList, nearest, idx, relIdx)
    end,

    build_position_cb = function(plist, _, _, _)
        require("scrollbar.handlers.search").handler.show(plist.start_pos)
    end
})

vim.cmd([[
    augroup scrollbar_search_hide
        autocmd!
        autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
    augroup END
]])
