local vim = vim

-- vim.fn.setenv("EXTENSION_WIKI_LINK", "1")
-- vim.fn.setenv("EXTENSION_TAGS", "1")

-- NOTES: replaced with nvim-ufo
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- local query = require("vim.treesitter.query")
-- local install = require("nvim-treesitter.install")
-- install.compilers = { "gcc" }

-- https://github.com/IndianBoy42/tree-sitter-just
-- parser_configs.markdown = {
--   install_info = {
--     url = "https://github.com/MDeiml/tree-sitter-markdown",
--     location = "tree-sitter-markdown",
--     files = { "src/parser.c", "src/scanner.c" },
--   },
--   maintainers = { "@MDeiml" },
--   readme_name = "markdown (basic highlighting)",
--   generate_requires_npm = true, -- if stand-alone parser without npm dependencies
--   requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
--   experimental = true,
-- }
--
-- parser_configs.markdown_inline = {
--   install_info = {
--     url = "https://github.com/MDeiml/tree-sitter-markdown",
--     location = "tree-sitter-markdown-inline",
--     files = { "src/parser.c", "src/scanner.c" },
--   },
--   maintainers = { "@MDeiml" },
--   readme_name = "markdown_inline (needed for full highlighting)",
--   experimental = true,
--   generate_requires_npm = true, -- if stand-alone parser without npm dependencies
--   requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
-- }

-- parser_configs.just = {
-- 	install_info = {
-- 		url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
-- 		files = { "src/parser.c", "src/scanner.cc" },
-- 		branch = "main",
-- 		-- use_makefile = true -- this may be necessary on MacOS (try if you see compiler errors)
-- 	},
-- 	-- maintainers = { "@IndianBoy42" },
-- }

