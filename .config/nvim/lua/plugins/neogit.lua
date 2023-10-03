vim.cmd.packadd("neogit")
local neogit = require("neogit")
neogit.setup({
  console_timeout = 10000,
})

vim.keymap.set("n", ";g", function()
    neogit.open({kind="split"})
end, { silent = true, desc = "" })
