local hostname = vim.uv.os_gethostname()

if hostname ~= "rok-toss-nix" and
    hostname ~= "root" then
    return
end

vim.cmd.packadd('copilot.lua')
require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 150,
    keymap = {
      accept = "<c-f>", -- Match
      accept_word = "false",
      accept_line = "false",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
})

-- vim.cmd.packadd('copilot-cmp')
-- require("copilot_cmp").setup()
