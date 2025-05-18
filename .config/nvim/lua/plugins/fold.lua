--
--
-- MAYBE?
-- https://github.com/anuvyklack/pretty-fold.nvim
-- https://github.com/snelling-a/better-folds.nvim

vim.cmd([[
packadd promise-async
packadd nvim-ufo
]])

require("ufo").setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "indent", "treesitter" }
	end,
})

--
-- vim.o.foldmethod = 'expr'
--
-- vim.keymap.set("n", "zO", require("ufo").openAllFolds)
-- vim.keymap.set("n", "zC", require("ufo").closeAllFolds)
--
-- require("ufo").setup({
-- -- provider_selector = function(bufnr, filetype, buftype)
-- --     return { "treesitter", "indent" }
-- -- end,
-- })
--

-- vim.cmd.packadd("fold-cycle.nvim")
-- require("fold-cycle").setup()
--
-- local function isfolded(line)
--    return vim.fn.foldclosed(line) == -1
-- end

-- -- toggle fold on current cursor
-- vim.keymap.set("n", "<tab>", function()
--     local lineNum = vim.api.nvim_win_get_cursor(0)[1]
--
--     if vim.fn.foldlevel(lineNum) == 0 then
--         -- vim.notify("no fold")
--         return
--     end
--     require('fold-cycle').toggle_all()
--
--     -- if isfolded(lineNum) then
--     --     -- print("is folded", lineNum)
--     --     -- vim.cmd("normal! zo")
--     -- else
--     --     -- print("is not folded", lineNum)
--     --     -- vim.cmd("normal! zc")
--     -- end
-- end, {
--     silent = true,
--     desc = "Fold-cycle",
-- })
