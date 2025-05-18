vim.cmd.packadd "cmdbuf.nvim"

vim.keymap.set("n", "q:", function()
  require("cmdbuf").split_open(vim.o.cmdwinheight)
end)

-- open lua command-line window
vim.keymap.set("n", "ql", function()
  require("cmdbuf").split_open(vim.o.cmdwinheight, { type = "lua/cmd" })
end)
