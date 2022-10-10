-- https://github.com/petertriho/nvim-scrollbar
vim.cmd [[
   packadd nvim-hlslens
   packadd nvim-scrollbar
]]

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

-- local kopts = {noremap = true, silent = true}
--
-- vim.api.nvim_set_keymap('n', 'n',
--     [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
--     kopts)
-- vim.api.nvim_set_keymap('n', 'N',
--     [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
--     kopts)
-- vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
-- vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
-- vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
-- vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
--
-- vim.api.nvim_set_keymap('n', '<Leader>l', ':noh<CR>', kopts)



-- require("hlslens").setup({
--    build_position_cb = function(plist, _, _, _)
--         require("scrollbar.handlers.search").handler.show(plist.start_pos)
--    end,
-- })
--
require("scrollbar").setup()

vim.cmd([[
    augroup scrollbar_search_hide
        autocmd!
        autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
    augroup END
]])
-- require("scrollbar.handlers.search").setup()
--
-- vim.cmd([[
--     augroup scrollbar_search_hide
--         autocmd!
--         autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
--     augroup END
-- ]])

-- vim.cmd [[
--
-- hi default link HlSearchNear Comment
-- hi default link HlSearchLens Comment
-- hi default link HlSearchLensNear Comment
-- hi default link HlSearchFloat Comment
-- ]]
