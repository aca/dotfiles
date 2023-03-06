local vim = vim

vim.defer_fn(function()
    vim.cmd.packadd("impatient.nvim")
    require("impatient")
    -- require("impatient").enable_profile()

    require("core.treesitter")
    require("core.lsp")
    require("core.luasnip")
    require("core.cmp")
    require("core.keymap")

    require("core.lazy")
    require("core.zettels")

    vim.cmd([[
        runtime! lua/plugins/*
        runtime! lua/command/*
        runtime! lua/autocmd/*
    ]])

    vim.defer_fn(function()
        -- prevent delay on startup
        vim.cmd([[ silent! helptags ALL ]])
    end, 100)
end, 50)
