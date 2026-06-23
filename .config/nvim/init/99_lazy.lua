-- vim.cmd.packadd("flatten.nvim")
-- require("flatten").setup()

-- vim.cmd.packadd("juan-logs.nvim")
--
-- require("juanlog").setup({
-- 	threshold_size = 1024 * 1024 * 100, -- 100MB trigger
-- 	mode = "dynamic", -- I don't remember the other mode name, but it's useless so don't worry
-- 	lazy = true, -- background indexing. prevents neovim from freezing
-- 	dynamic_chunk_size = 10000, -- lines to load at once
-- 	dynamic_margin = 2000, -- trigger scroll load when this close to the edge
-- 	patterns = { "*.log", "*.txt", "*.csv", "*.json" },
-- 	enable_custom_statuscol = true, -- fakes absolute line numbers
-- 	syntax = false, -- set to true to enable native vim syntax (can be slow)
-- })

vim.defer_fn(function()
require("lazy")
end, 50)

-- this doesn't work
-- vim.o.syntax="off"
-- vim.o.syntax="off"
-- vim.cmd [[
--   syntax off
-- ]]
