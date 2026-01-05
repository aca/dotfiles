vim.cmd.packadd("nvim-treesitter")
vim.cmd.packadd("nvim-treesitter-textobjects")
-- vim.cmd.packadd("nvim-treesitter-context")

-- require'treesitter-context'.setup{
--   -- enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
--   -- multiwindow = false, -- Enable multiwindow support.
--   -- max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
--   -- min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
--   -- line_numbers = true,
--   -- multiline_threshold = 20, -- Maximum number of lines to show for a single context
--   -- trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--   -- mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
--   -- -- Separator between context and content. Should be a single character string, like '-'.
--   -- -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
--   -- separator = nil,
--   -- zindex = 20, -- The Z-index of the context window
--   -- on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
-- }

-- vim.keymap.set("n", "[c", function()
--   require("treesitter-context").go_to_context(vim.v.count1)
-- end, { silent = false })
--
-- vim.keymap.set("n", "]c", function()
--   require("treesitter-context").go_to_context(vim.v.count1)
-- end, { silent = false })

require("nvim-treesitter-textobjects").setup({
	select = {
		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,
		-- You can choose the select mode (default is charwise 'v')
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * method: eg 'v' or 'o'
		-- and should return the mode ('v', 'V', or '<c-v>') or a table
		-- mapping query_strings to modes.
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@function.outer"] = "V", -- linewise
			-- ['@class.outer'] = '<c-v>', -- blockwise
		},
		-- If you set this to `true` (default is `false`) then any textobject is
		-- extended to include preceding or succeeding whitespace. Succeeding
		-- whitespace has priority in order to act similarly to eg the built-in
		-- `ap`.
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * selection_mode: eg 'v'
		-- and should return true of false
		include_surrounding_whitespace = false,
	},
})

-- keymaps
-- -- You can use the capture groups defined in `textobjects.scm`
vim.keymap.set({ "x", "o" }, "af", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o" }, "as", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
end)
