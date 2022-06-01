-- 20:11 λ vim-startuptime --vimpath nvim | head -n 20
-- Extra options: []
-- Measured: 10 times
--
-- Total Average: 9.235800 msec
-- Total Max:     9.450000 msec
-- Total Min:     9.120000 msec
--
--  AVERAGE      MAX      MIN
-- ---------------------------
-- 2.086300 2.133000 2.025000: /home/rok/.config/nvim/init.lua

require("settings")
require("colors")
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
end, 40)
