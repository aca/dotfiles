vim.cmd([[ packadd blink.cmp ]])
require("blink-cmp").setup({
    fuzzy = {
        prebuilt_binaries = {
            ignore_version_mismatch = true,
        },
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

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		-- default = { 'lsp' },
		cmdline = {},
	},
})
