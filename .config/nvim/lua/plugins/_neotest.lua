-- if not pcall(require, "nvim-treesitter") then
-- 	return
-- end

vim.cmd.packadd("nvim-treesitter")
vim.cmd.packadd("nvim-nio")
vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("neotest")
vim.cmd.packadd("neotest-golang")

vim.keymap.set("n", ";t", function()
	require("neotest").run.run()
end, { desc = "Run nearest test" })

-- require("neotest").setup({
-- 	adapters = {
-- 		require("neotest-golang")(),
-- 	},
-- })

require("neotest").setup({
  adapters = {
    require("neotest-golang")
  },
})
