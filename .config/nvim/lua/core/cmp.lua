vim.cmd.packadd([[ blink.cmp ]])
-- print(pcall(require, 'blink.cmp'))
-- print(pcall(require, 'blink'))
-- print(pcall(require, 'blink_cmp'))
require("blink-cmp").setup({
	-- 'default' for mappings similar to built-in completion
	-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
	-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
	-- See the full "keymap" documentation for information on defining your own keymap.
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

	-- appearance = {
	--   -- Sets the fallback highlight groups to nvim-cmp's highlight groups
	--   -- Useful for when your theme doesn't support blink.cmp
	--   -- Will be removed in a future release
	--   use_nvim_cmp_as_default = true,
	--   -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
	--   -- Adjusts spacing to ensure icons are aligned
	--   nerd_font_variant = 'mono'
	-- },
	--
	-- -- Default list of enabled providers defined so that you can extend it
	-- -- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		-- default = { 'lsp' },
        cmdline = {},
	},

	-- completion = {
	-- 	menu = {
 --            auto_show = false,
	-- 		-- auto_show = function(ctx)
	-- 		-- 	return ctx.mode ~= "cmdline"
	-- 		-- end,
	-- 	},
	-- },
})
