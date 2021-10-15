vim.cmd([[
        packadd playground
        packadd nvim-treesitter
        packadd nvim-ts-rainbow
]])

-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1383
-- require 'nvim-treesitter.install'.compilers = { "gcc" }

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
	-- ensure_installed = "all",
	ensure_installed = "maintained",
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
  --   "vim",
	-- },
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = false,
	},
})

vim.cmd([[

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

]])

-- https://www.reddit.com/r/neovim/comments/pmknoi/nextbestthing_to_treesitter_for_markdown/
-- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
--
-- parser_configs.markdown = {
--   install_info = {
--     url = "https://github.com/ikatyang/tree-sitter-markdown",
--     files = { "src/parser.c", "src/scanner.cc" },
--   },
--   filetype = "markdown",
-- }
--
