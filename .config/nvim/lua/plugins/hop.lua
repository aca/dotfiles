vim.cmd([[packadd hop.nvim]])
require("hop").setup()

vim.keymap.set("n", "s", function()
	require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = false })
end)
vim.keymap.set("n", "S", function()
	require("hop").hint_char1({
		direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
		current_line_only = false,
	})
end)
vim.keymap.set("n", "<leader>w", function()
	require("hop").hint_words({})
end)
