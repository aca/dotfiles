vim.defer_fn(function()
    -- require("impatient").enable_profile()
    require("impatient")
    vim.cmd([[
    	packadd nvim-treesitter
    	packadd nvim-treesitter-context
    	packadd playground
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
    -- require("plugins.luasnip_go")
    require("plugins.cmp")
    require("plugins.autopairs")
    require("keymap")
    -- require("zettels")

    vim.cmd([[
         source ~/.config/nvim/lua/lazy/init.vim
         runtime! lua/lazy/plugins/*
         runtime! lua/lazy/funcs/*
         runtime! lua/lazy/command/*
         runtime! lua/lazy/local/*
         runtime! lua/lazy/autocmd/*
         silent! helptags ALL
    ]])
end, 100)
