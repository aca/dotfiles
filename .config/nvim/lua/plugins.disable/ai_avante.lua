vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("nui.nvim")
vim.cmd.packadd("dressing.nvim")
vim.cmd.packadd("render-markdown.nvim")
vim.cmd.packadd("avante.nvim")

require("avante_lib").load({
	provider = "copilot",
	-- claude = {
	-- 	endpoint = "https://api.anthropic.com",
	-- 	model = "claude-3-5-sonnet-20241022",
	-- 	temperature = 0,
	-- 	max_tokens = 4096,
	-- },
})
require("avante").setup()
