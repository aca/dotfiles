vim.cmd([[
        packadd nvim-treesitter
        " packadd nvim-ts-rainbow
        " packadd playground
]])

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
local query = require("vim.treesitter.query")
local install = require("nvim-treesitter.install")

-- NOTES: https://github.com/tree-sitter/tree-sitter-haskell#building-on-macos
-- if vim.g._uname == "macOS" then
-- end
install.compilers = { "gcc" }

parser_config.markdown = {
	install_info = {
		url = "https://github.com/MDeiml/tree-sitter-markdown",
		branch = "main",
		files = { "src/parser.c", "src/scanner.cc" },
	},
	filetype = "markdown",
}

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
		max_file_lines = 200, -- Do not enable for files with more than 1000 lines, int
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			scope_incremental = "<CR>",
			node_incremental = "<TAB>",
			node_decremental = "<S-TAB>",
		},
	},
	-- ensure_installed = "all",
	-- ensure_installed = "maintained",
	-- ensure_installed = { "c", "rust", "python", "go", "cpp", "bash" },
	-- disable = { "vim" },
	disable = {},
	enable = "all",
	-- enable = {
	-- 	"go",
	-- 	"c",
	-- 	"rust",
	-- 	"python",
	-- 	"javascript",
	-- 	"typescript",
	-- 	"bash",
	-- 	"fish",
	-- 	"cpp",
	-- 	"dockerfile",
	-- 	"gomod",
	-- 	"html",
	--  "vim",
	-- },
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		disable = {},
	},
})

-- vim.cmd([[
-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()
-- ]])
