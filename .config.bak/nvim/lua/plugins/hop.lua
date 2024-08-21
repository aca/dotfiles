vim.cmd.packadd 'hop.nvim'
local hop = require("hop")
hop.setup()

-- vim.keymap.set("n", "s", function()
--     hop.hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = false })
-- end)
-- vim.keymap.set("n", "S", function()
--     hop.hint_char1({
--         direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
--         current_line_only = false,
--     })
-- end)
-- vim.keymap.set("n", "<leader>w", function()
vim.keymap.set("n", "gw", function()
    hop.hint_words({})
end)

-- vim.cmd.packadd'pounce.nvim'
-- local map = vim.keymap.set
-- map("n", "s", function() require'pounce'.pounce { } end)
-- map("n", "s", function() require'pounce'.pounce { do_repeat = true } end)
-- map("x", "s", function() require'pounce'.pounce { } end)
-- map("o", "gs", function() require'pounce'.pounce { } end)
-- map("n", "S", function() require'pounce'.pounce { input = {reg="/"} } end)


-- https://github.com/easymotion/vim-easymotion
-- https://github.com/justinmk/vim-sneak
-- https://github.com/phaazon/hop.nvim
-- https://github.com/ggandor/lightspeed.nvim
-- https://github.com/yuki-yano/fuzzy-motion.vim
-- https://github.com/hrsh7th/vim-searchx
