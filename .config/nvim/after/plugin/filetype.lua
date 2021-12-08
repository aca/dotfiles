-- In init.lua or filetype.nvim's config file
require("filetype").setup({

	overrides = {
		extensions = {
			-- Set the filetype of *.pn files to potion
			elv = "elvish",
		},
		shebang = {
			-- Set the filetype of files with a dash shebang to sh
			bash = "bash",
		},
	},
})
