-- folke/zen-mode.nvim

vim.cmd([[
  packadd zen-mode.nvim
  nnoremap <silent> <bslash>z :ZenMode<CR>
]])

require("zen-mode").setup({
	window = {
		options = {
			number = false,
			relativenumber = false,
		},
		width = 120, -- width of the Zen window
		-- height = 30, -- height of the Zen window
	},
	plugins = {
		gitsigns = { enabled = true },
	},
})
