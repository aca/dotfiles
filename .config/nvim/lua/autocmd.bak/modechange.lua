-- vim.api.nvim_create_autocmd({ "ModeChanged" }, {
-- 	pattern = { "*:[V\x16]*" },
-- 	callback = function()
-- 		print("mode changed")
-- 	end,
-- })
-- vim.api.nvim_create_autocmd("ModeChanged", {
-- 	pattern = "*:[vV\x16]",
-- 	callback = function()
-- 		print("mode changed")
-- 	end,
-- })
--
-- ---Reset visual highlight
-- vim.api.nvim_create_autocmd("ModeChanged", {
-- 	pattern = "[vV\x16]:n",
-- 	callback = M.reset,
-- })
-- https://github.com/mvllow/modes.nvim
