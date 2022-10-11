-- NOTES: https://github.com/neovim/neovim/pull/19243
-- vim.cmd([[packadd stabilize.nvim]])
-- require("stabilize").setup()
--
-- https://www.reddit.com/r/neovim/comments/xx3fom/new_option_splitkeep_merged_into_master/https://www.reddit.com/r/neovim/comments/xx3fom/new_option_splitkeep_merged_into_master/
pcall(function ()
    vim.o.splitkeep="screen"
end)
