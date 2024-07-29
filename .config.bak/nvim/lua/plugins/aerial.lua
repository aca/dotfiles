vim.cmd.packadd("nvim-web-devicons")
require("nvim-web-devicons").setup({
    -- color_icons = false,
})

-- vim.cmd.packadd("lspkind.nvim")
-- require("lspkind").init()

-- Function = "󰊕",
-- Constructor = "",
-- Field = "󰜢",
-- Variable = "󰀫",
-- Class = "󰠱",
-- Interface = "",
-- Module = "",
-- Property = "󰜢",
-- Unit = "󰑭",
-- Value = "󰎠",
-- Enum = "",
-- Keyword = "󰌋",
-- Snippet = "",
-- Color = "󰏘",

vim.cmd.packadd("aerial.nvim")
local aerial = require("aerial")
aerial.setup({
    -- backends = {
    --     ["_"] = { "lsp", "treesitter" },
    --     -- ['python'] = {"treesitter"},
    --     -- ['rust']   = {"lsp"},
    --     ["markdown"] = { "treesitter" },
    -- },
    filter_kind = false,

    -- open_automatic = function(bufnr)
    --     -- return false
    --     return not aerial.was_closed and vim.api.nvim_buf_line_count(bufnr) > 80 and aerial.num_symbols(bufnr) > 3
    -- end,

    -- nerd_font = true,
    -- icons = {
    --   Function = "*",
    -- },
    -- use_lspkind = true,


    layout = {
        max_width = { 30, 0.25 },
        width = nil,
        min_width = 25,
        default_direction = "left",
    },
    show_guides = true,
})
