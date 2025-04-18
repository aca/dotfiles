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
		width = 80, -- width of the Zen window
		-- height = 30, -- height of the Zen window
	},
	plugins = {
		gitsigns = { enabled = true },
		tmux = { enabled = false }, -- disables the tmux statusline
	},
})
