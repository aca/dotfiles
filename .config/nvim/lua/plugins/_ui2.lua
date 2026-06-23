require("vim._core.ui2").enable({ enable = true, msg = { target = "msg" } })

-- vim.cmd.packadd("fff.nvim")
--
vim.cmd.packadd("minibuffer.nvim")
local minibuffer = require("minibuffer")

vim.ui.select = require("minibuffer.builtin.ui_select")
vim.ui.input = require("minibuffer.builtin.ui_input")


-- local picker_ui = require("fff.picker_ui")
-- picker_ui.open = require("minibuffer.integrations.fff")

-- vim.keymap.set("n", "<leader>ff", require("minibuffer.builtin.files"))
-- vim.keymap.set("n", "<leader>ff", require('fff').find_files)
