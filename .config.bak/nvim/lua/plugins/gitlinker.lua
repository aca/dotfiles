local vim = vim
vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("gitlinker.nvim")

require("gitlinker").setup({
	mapping = {},
	router = {
		browse = {
			["github.*.*"] = require("gitlinker.routers").github_browse,
		},
		blame = {
			["github.*.*"] = require("gitlinker.routers").github_blame,
		},
	},
})
