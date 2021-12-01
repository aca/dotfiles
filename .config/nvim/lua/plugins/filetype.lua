-- In init.lua or filetype.nvim's config file
require("filetype").setup({
	overrides = {
		shebang = {
			-- Set the filetype of files with a dash shebang to sh
			bash = "bash",
		},
	},
})
