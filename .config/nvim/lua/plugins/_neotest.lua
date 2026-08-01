-- if not pcall(require, "nvim-treesitter") then
-- 	return
-- end

vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git' } })
vim.pack.add({ { src = 'https://github.com/nvim-neotest/nvim-nio.git' } })
vim.pack.add({ { src = 'https://github.com/nvim-lua/plenary.nvim.git' } })

-- require("neotest").setup({
-- 	adapters = {
-- 		require("neotest-golang")(),
-- 	},
-- })

-- vim.cmd.packadd("neotest")
-- vim.cmd.packadd("neotest-golang")
--
-- vim.keymap.set("n", ";t", function()
-- 	require("neotest").run.run()
-- end, { desc = "Run nearest test" })
--
--
-- require("neotest").setup({
--   adapters = {
--     require("neotest-golang")
--   },
-- })
