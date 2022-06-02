require("settings")
require("colors")
-- dofile(xdg_config .. "/colors.ljbc")
require("autocmds")

vim.defer_fn(function()
    require("impatient")
    -- require("impatient").enable_profile()

    vim.cmd([[
      packadd nvim-lspconfig
      packadd nvim-lsp-installer
      packadd nvim-treesitter
      packadd playground
    ]])

    require("plugins.treesitter")
    require("plugins.lsp")
    -- require("plugins.dap")
    require("statusline")
    require("plugins.luasnip")
    require("plugins.cmp")
    require("plugins.autopairs")
    -- TODO
    -- - ./autoload/map/map.vim -> ./lua/keymap.lua
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
end, 200)
