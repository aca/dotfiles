local xdg_config = vim.fn.stdpath("config") .. "/lua"
dofile(xdg_config .. "/settings.lua")
dofile(xdg_config .. "/colors.lua")
dofile(xdg_config .. "/autocmds.lua")

vim.defer_fn(function()
    -- require("impatient").enable_profile()
    require("impatient")

    vim.cmd([[
        packadd nvim-treesitter
    ]])
    require("plugins.treesitter")


    vim.cmd([[
        packadd nvim-lspconfig
        packadd nvim-lsp-installer
    ]])
    require("plugins.lsp")

    -- require("plugins.dap")
    require("statusline")
    require("plugins.luasnip")
    require("plugins.cmp")
    require("plugins.autopairs")
    require("keymap")
    -- require("zettels")

    vim.cmd([[
         source ~/.config/nvim/lazy/init.vim
         runtime! lazy/plugins/*
         runtime! lazy/funcs/*
         runtime! lazy/autocmd/*
         runtime! lazy/command/*
         runtime! lazy/local/*
         silent! helptags ALL
    ]])
end, 1)
