local vim = vim

vim.cmd([[ 
    packadd nvim-treesitter
    " packadd nvim-ts-rainbow
    " packadd nvim-treesitter-context
    "packadd nvim-treesitter-textobjects
    "packadd nvim-ts-context-commentstring
    " packadd contextindent.nvim
    " packadd playground
]])

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
	autopairs = {
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		enable = false,
	},
	highlight = {
		-- NOTE: treesitter highlight blocks UI, shows worse performance in many cases
		-- enable = {
		--           "go",
		--           "bash",
		--           "svelte",
		--       },
		enable = false,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		-- disable = {
		-- 	"markdown",
		-- },
		additional_vim_regex_highlighting = false,
	},
})

local function safe_treesitter_start(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if not ft or ft == "" then return end

  local parsers = require("nvim-treesitter.parsers")
  local lang = parsers.ft_to_lang(ft)

  if parsers.has_parser(lang) then
    vim.treesitter.start(bufnr)
  end
end

safe_treesitter_start(0)
