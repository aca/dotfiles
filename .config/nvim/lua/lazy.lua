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
         source ~/.config/nvim/lazy/init.vim
         runtime! lazy/plugins/*
         runtime! lazy/funcs/*
         runtime! lazy/autocmd/*
         runtime! lazy/command/*
         runtime! lazy/local/*
         silent! helptags ALL
    ]])
end, 100)
