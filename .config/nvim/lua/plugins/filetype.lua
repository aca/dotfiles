-- TODO: remove when it's merged to core
-- In init.lua or filetype.nvim's config file
require("filetype").setup({
	overrides = {
		extensions = {
			-- Set the filetype of *.pn files to potion
			elv = "elvish",
			keymap = "c",
		},
		shebang = {
			bash = "bash",
			raku = "raku",
		},
	},
})

vim.cmd([[
autocmd FileType bash,c,c_sharp,clojure,cmake,comment,commonlisp,cpp,css,dockerfile,fennel,fish,go,gomod,graphql,hcl,html,java,javascript,jsdoc,json,jsonc,lua,vim syntax off
autocmd FileType markdown syntax off
]])
