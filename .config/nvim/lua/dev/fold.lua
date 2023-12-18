-- MAYBE?
-- https://github.com/anuvyklack/pretty-fold.nvim
-- https://github.com/snelling-a/better-folds.nvim

vim.cmd([[
packadd promise-async
packadd nvim-ufo
]])

vim.o.foldmethod = 'expr'

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

require("ufo").setup({
provider_selector = function(bufnr, filetype, buftype)
    return { "treesitter", "indent" }
end,
})

vim.cmd.packadd("fold-cycle.nvim")
require("fold-cycle").setup()

vim.keymap.set('n', '<tab>',
  function() return require('fold-cycle').open() end,
  {silent = true, desc = 'Fold-cycle: open folds'})
vim.keymap.set('n', '<s-tab>',
  function() return require('fold-cycle').close() end,
  {silent = true, desc = 'Fold-cycle: close folds'})
vim.keymap.set('n', 'zC',
  function() return require('fold-cycle').close_all() end,
  {remap = true, silent = true, desc = 'Fold-cycle: close all folds'})

local function isfolded(line)
    local folded
    if vim.fn.foldclosed(line) == -1 then
        folded = false
    else
        folded = true
    end
    return folded
end

-- toggle fold on current cursor
vim.keymap.set("n", "<tab>", function()
    local lineNum = vim.api.nvim_win_get_cursor(0)[1]

    if isfolded(lineNum) then
        -- print("is folded", lineNum)
        vim.cmd("normal! zo")
    else
        -- print("is not folded", lineNum)
        vim.cmd("normal! zc")
    end
end, {
    silent = true,
    desc = "Fold-cycle: open folds",
})
