vim.cmd [[ packadd vim-fold-cycle ]]

-- vim.cmd([[ packadd fold-cycle.nvim ]])
-- require("fold-cycle").setup()
--
-- vim.keymap.set("n", "<cr>", function()
-- 	return require("fold-cycle").toggle_all()
-- end, { silent = true, desc = "Fold-cycle: open folds" })
-- -- vim.keymap.set("n", "<s-tab>", function()
-- --     return require("fold-cycle").close()
-- -- end, { silent = true, desc = "Fold-cycle: close folds" })
-- -- vim.keymap.set("n", "zC", function()
-- --     return require("fold-cycle").close_all()
-- -- end, { remap = true, silent = true, desc = "Fold-cycle: close all folds" })
