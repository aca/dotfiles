vim.cmd.packadd("flatten.nvim")
require("flatten").setup()
vim.defer_fn(function()
	require("lazy")
end, 100)

-- this doesn't work
-- vim.o.syntax="off"
-- vim.o.syntax="off"
-- vim.cmd [[
--   syntax off
-- ]]
