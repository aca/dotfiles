vim.cmd([[
packadd aerial.nvim
]])

local aerial = require("aerial")
aerial.setup({
    backends = {
        ["_"] = { "lsp", "treesitter" },
        -- ['python'] = {"treesitter"},
        -- ['rust']   = {"lsp"},
        ["markdown"] = { "treesitter" },
    },
    open_automatic = function(bufnr)
        return false
        -- return not aerial.was_closed and vim.api.nvim_buf_line_count(bufnr) > 80 and aerial.num_symbols(bufnr) > 3
    end,

    default_direction = "left",

    min_width = 25,
    show_guides = true,
})

