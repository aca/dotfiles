local vim = vim

if vim.env.VIM_DISABLE_TREESITTER == "1" then
	return
end

vim.cmd([[ 
    packadd nvim-treesitter
    " packadd nvim-ts-rainbow
    packadd nvim-treesitter-context
    packadd nvim-treesitter-textobjects
    packadd nvim-ts-context-commentstring
    " packadd contextindent.nvim
    " packadd playground
]])

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

require("nvim-treesitter.configs").setup({
	enable = true,
	-- disable = {
	-- 	"json",
	-- 	"jsonc",
	-- 	"yaml",
	-- 	"c",
	-- },
	sync_install = false,
	auto_install = false,
	ensure_installed = {},
	modules = {},
	ignore_install = {},
	-- ignore_install = { "wing" },
	-- context_commentstring = {
	--     enable = true,
	--     enable_autocmd = false,
	--     config = {
	--         javascript = {
	--             __default = "// %s",
	--             jsx_element = "{/* %s */}",
	--             jsx_fragment = "{/* %s */}",
	--             jsx_attribute = "// %s",
	--             comment = "// %s",
	--         },
	--         typescript = { __default = "// %s", __multiline = "/* %s */" },
	--     },
	-- },
	-- textobjects = {
	-- 	move = {
	-- 		enable = false,
	-- 		set_jumps = true, -- whether to set jumps in the jumplist
	-- 		goto_next_start = {
	-- 			["]m"] = "@function.outer",
	-- 			["]]"] = { query = "@class.outer", desc = "Next class start" },
	-- 			--
	-- 			-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
	-- 			["]o"] = "@loop.*",
	-- 			-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
	-- 			--
	-- 			-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
	-- 			-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
	-- 			["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
	-- 			["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
	-- 		},
	-- 		goto_next_end = {
	-- 			["]M"] = "@function.outer",
	-- 			["]["] = "@class.outer",
	-- 		},
	-- 		goto_previous_start = {
	-- 			["[m"] = "@function.outer",
	-- 			["[["] = "@class.outer",
	-- 		},
	-- 		goto_previous_end = {
	-- 			["[M"] = "@function.outer",
	-- 			["[]"] = "@class.outer",
	-- 		},
	-- 		-- Below will go to either the start or the end, whichever is closer.
	-- 		-- Use if you want more granular movements
	-- 		-- Make it even more gradual by adding multiple queries and regex.
	-- 		goto_next = {
	-- 			["<tab>"] = "@*",
	-- 		},
	-- 		goto_previous = {
	-- 			["[d"] = "@conditional.outer",
	-- 		},
	-- 	},
	-- 	select = {
	-- 		enable = false,
	--
	-- 		-- Automatically jump forward to textobj, similar to targets.vim
	-- 		lookahead = true,
	--
	-- 		keymaps = {
	-- 			-- You can use the capture groups defined in textobjects.scm
	-- 			["af"] = "@function.outer",
	-- 			["if"] = "@function.inner",
	-- 			["ac"] = "@class.outer",
	-- 			-- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
	-- 			["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
	-- 		},
	-- 		-- You can choose the select mode (default is charwise 'v')
	-- 		selection_modes = {
	-- 			["@parameter.outer"] = "v", -- charwise
	-- 			["@function.outer"] = "V", -- linewise
	-- 			["@class.outer"] = "<c-v>", -- blockwise
	-- 		},
	-- 		-- If you set this to `true` (default is `false`) then any textobject is
	-- 		-- extended to include preceding xor succeeding whitespace. Succeeding
	-- 		-- whitespace has priority in order to act similarly to eg the built-in
	-- 		-- `ap`.
	-- 		include_surrounding_whitespace = true,
	-- 	},
	-- },
	-- indent = {
	-- 	enable = false,
	-- },
	-- matchup = {
	--     enable = true,
	-- },
	-- rainbow = {
	-- 	enable = true,
	-- 	extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
	-- 	max_file_lines = 150, -- Do not enable for files with more than 1000 lines, int
	-- },
	-- incremental_selection = {
	--     enable = true,
	--     keymaps = {
	--         -- init_selection = "<CR>",
	--         -- scope_incremental = "<CR>",
	--         init_selection = "<tab>",
	--         -- scope_incremental = "<TAB>",
	--         node_incremental = "<tab>",
	--         node_decremental = "<s-tab>",
	--     },
	-- },
	-- enable = "all",
	-- NOTE: elixir TS returns error, remove this later
	-- disable = {
	-- 	"c",
	-- 	"ada",
	-- 	"beancount",
	-- 	"go",
	-- 	"dockerfile",
	-- 	"cooklang",
	-- 	"glimmer",
	-- 	"foam",
	-- 	"m68k",
	-- 	"pioasm",
	-- 	"pug",
	-- 	"v",
	-- 	"astro",
	-- 	"beancount",
	-- 	"bibtex",
	-- 	"cooklang",
	-- 	"ecma",
	-- 	"eex",
	-- 	"fortran",
	-- 	"fusion",
	-- 	"norg",
	-- 	"sparql",
	-- 	"surface",
	-- 	"supercollider",
	-- 	"swift",
	-- 	"tlaplus",
	-- 	"todotxt",
	-- 	"yang",
	-- 	"ocaml",
	-- 	"wing",
	-- 	"ninja",
	-- 	"ocamllex",
	-- 	"ocaml_interface",
	-- 	"ql",
	-- 	"eex",
	-- 	"devicetree",
	-- 	"fortran",
	-- 	"fusion",
	-- 	"gdscript",
	-- 	"godot_resource",
	-- 	"hack",
	-- 	"hjson",
	-- 	"heex",
	-- 	"glsl",
	-- 	"gleam",
	-- 	"smithy",
	-- 	"d",
	-- 	"lalrpop",
	-- },
	autopairs = {
		disable = function(lang, bufnr) -- Disable in large C++ buffers
			-- NOTE: treesitter highlight blocks UI, shows worse performance in many cases
			-- vim.notify("treesitter-autopairs is disable")
			return vim.api.nvim_buf_line_count(bufnr) > 10000
		end,
		enable = true,
	},
	highlight = {
		-- NOTE: treesitter highlight blocks UI, shows worse performance in many cases
		-- enable = {
		--           "go",
		--           "bash",
		--           "svelte",
		--       },
		enable = true,
		-- disable = {
		-- 	"markdown",
		-- },
		additional_vim_regex_highlighting = false,
	},
})

require("treesitter-context").setup({
    enable = true,
})

-- https://github.com/echasnovski/nvim/blob/34506b1682b56f1f617fd31d2dfe3c72497dd17d/lua/ec/configs/nvim-treesitter.lua#L133
-- requires folds.scm
local query = require("nvim-treesitter.query")
local parsers = require("nvim-treesitter.parsers")
local ts_utils = require("nvim-treesitter.ts_utils")

local folds_levels = ts_utils.memoize_by_buf_tick(function(bufnr)
	local parser = parsers.get_parser(bufnr)

	if not (parser and query.has_folds("markdown")) then
		return {}
	end

	local levels = {}

	-- NOTE: don't use `_recursive` variant to fold only based on markdown itself
	local matches = query.get_capture_matches(bufnr, "@fold", "folds") or {}
	for _, m in pairs(matches) do
		local node = m.node
		local s_row, _, e_row, _ = node:range()
		local node_is_heading = node:type() == "atx_heading" or node:type() == "setext_heading"
		-- local node_is_code = node:type() == "fenced_code_block"

		-- Process heading. Start fold at start line of heading with fold level
		-- equal to header level.
		if node_is_heading then
			for child in node:iter_children() do
				local _, _, level = string.find(child:type(), "h([0-9]+)")
				if level ~= nil then
					levels[s_row] = (">%s"):format(level)
					break
				end
			end
		end

		-- Process code block. Add fold level at start line and subtract at end.
		-- if node_is_code then
		-- 	levels[s_row] = "a1"
		-- 	levels[e_row - 1] = "s1"
		-- end
	end

	return levels
end)

_G._markdown_foldexpr = function()
	local levels = folds_levels(vim.api.nvim_get_current_buf()) or {}
	return levels[vim.v.lnum - 1] or "="
end

-- for lazyload
if vim.bo.filetype == "markdown" then
	vim.cmd([[
        setlocal foldexpr=v:lua._markdown_foldexpr()
        " normal! zx
    ]])
end

-- add autocmd
vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "markdown" },
	command = "setlocal foldexpr=v:lua._markdown_foldexpr()",
})

-- require("vim.treesitter.query").set_query(
--     "markdown",
--     "highlights",
--     [[
-- (atx_heading (inline) @text.title)
-- (setext_heading (paragraph) @text.title)
--
-- [
--   (atx_h1_marker)
--   (atx_h2_marker)
--   (atx_h3_marker)
--   (atx_h4_marker)
--   (atx_h5_marker)
--   (atx_h6_marker)
--   (setext_h1_underline)
--   (setext_h2_underline)
-- ] @punctuation.special
--
-- [
--   (link_title)
--   (indented_code_block)
--   (fenced_code_block)
-- ] @text.literal
--
-- [
--   (fenced_code_block_delimiter)
-- ] @punctuation.delimiter
--
-- (code_fence_content) @none
--
-- [
--   (link_destination)
-- ] @text.uri
--
-- [
--   (link_label)
-- ] @text.reference
--
-- [
--   (list_marker_plus)
--   (list_marker_minus)
--   (list_marker_star)
--   (list_marker_dot)
--   (list_marker_parenthesis)
--   (thematic_break)
-- ] @punctuation.special
--
-- [
--   (block_continuation)
--   (block_quote_marker)
-- ] @punctuation.special
--
-- [
--   (backslash_escape)
-- ] @string.escape
--
-- ([
--   (info_string)
-- ] @conceal
-- (#set! conceal ""))
-- ]]
-- )

-- require("vim.treesitter.query").set_query("markdown", "folds", [[
-- [
--   (atx_heading)
--   (setext_heading)
-- ] @fold
-- ]])
--

