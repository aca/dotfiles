vim.cmd([[ packadd blink.cmp ]])
require("blink-cmp").setup({
    fuzzy = { 
        implementation = "prefer_rust",
        prebuilt_binaries = { 
            ignore_version_mismatch = true,
        },
    },

	completion = {
		-- 'prefix' will fuzzy match on the text before the cursor
		-- 'full' will fuzzy match on the text before *and* after the cursor
		-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
		keyword = { range = "full" },

		-- Disable auto brackets
		-- NOTE: some LSPs may add auto brackets themselves anyway
		accept = { auto_brackets = { enabled = false } },

		-- Don't select by default, auto insert on selection
		list = { selection = { preselect = false, auto_insert = true } },
	},
	keymap = {
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<CR>"] = { "accept", "fallback" },

		["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },

		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },

		-- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		-- ["<C-e>"] = { "hide", "fallback" },
		--
		-- ["<Tab>"] = {
		-- 	function(cmp)
		-- 		if cmp.snippet_active() then
		-- 			return cmp.accept()
		-- 		else
		-- 			return cmp.select_and_accept()
		-- 		end
		-- 	end,
		-- 	"snippet_forward",
		-- 	"fallback",
		-- },
		-- ["<S-Tab>"] = { "snippet_backward", "fallback" },
		--
		-- ["<Up>"] = { "select_prev", "fallback" },
		-- ["<Down>"] = { "select_next", "fallback" },
		-- ["<C-p>"] = { "select_prev", "fallback" },
		-- ["<C-n>"] = { "select_next", "fallback" },
		--
		-- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
		-- ["<C-f>"] = { "scroll_documentation_down", "fallback" },
	},

    cmdline = {
        enabled = false,
    },

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		-- default = { 'lsp' },
	},
})
