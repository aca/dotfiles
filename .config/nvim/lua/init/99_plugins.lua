local vim = vim
vim.loader.enable()

require("core.treesitter")
local load = function()
    vim.cmd [[ runtime! lua/core/fzf.vim ]]
    require("core.keymap")
    require("core.luasnip")
    require("core.cmp")
    require("core.lsp")

    require("core.lazy")
    -- require("core.zettels")

    vim.cmd([[
        runtime! lua/plugins/*
        runtime! lua/command/*
        runtime! lua/autocmd/*
        runtime! local/*
    ]])

    vim.defer_fn(function()
        -- prevent delay on startup
        vim.cmd([[ silent! helptags ALL ]])
    end, 200)
end

-- load()
vim.defer_fn(load, 80)
