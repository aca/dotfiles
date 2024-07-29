local hostname = vim.uv.os_gethostname()

if hostname ~= "rok-txxx-nix" and hostname ~= "root" then
	return
end

vim.cmd.packadd("copilot.lua")
require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept = "<c-f>", -- Match
			accept_word = "true",
			accept_line = "true",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},
})

-- vim.cmd.packadd('copilot-cmp')
-- require("copilot_cmp").setup()
