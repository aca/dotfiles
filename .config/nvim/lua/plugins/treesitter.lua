vim.cmd([[
        packadd nvim-treesitter
        " packadd nvim-ts-rainbow
        " packadd playground
]])

-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- local query = require("vim.treesitter.query")
local install = require("nvim-treesitter.install")

-- NOTES: https://github.com/tree-sitter/tree-sitter-haskell#building-on-macos
-- if vim.g._uname == "macOS" then
-- end
install.compilers = { "gcc" }

require("nvim-treesitter.configs").setup({
	playground = {
		enable = true,
	},
	matchup = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
		max_file_lines = 150, -- Do not enable for files with more than 1000 lines, int
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			-- init_selection = "<CR>",
			-- scope_incremental = "<CR>",
			init_selection = "<CR>",
			-- scope_incremental = "<TAB>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
		},
	},
	enable = "all",
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		-- NOTE: elixir TS returns error, remove this later
		disable = {
			"elixir",
		},
	},
})
