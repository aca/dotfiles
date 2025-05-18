vim.defer_fn(function()
	require("init-lazy")
end, 100)

-- this doesn't work
-- vim.o.syntax="off"
-- vim.o.syntax="off"
-- vim.cmd [[
--   syntax off
-- ]]
