--
-- :lua= sth_to_print
-- :lua print(vim.inspect(sth_to_print))

-- require("impatient").enable_profile()
require("impatient")

-- 22:51 λ vim-startuptime --vimpath nvim | head -n 10
-- Extra options: []
-- Measured: 10 times
--
-- Total Average: 23.523000 msec
-- Total Max:     25.588000 msec
-- Total Min:     22.778000 msec
--
--   AVERAGE       MAX       MIN
-- ------------------------------
-- 17.173100 19.155000 16.498000: /home/rok/.config/nvim/init.lua

vim.cmd([[
  " lsp
  packadd nvim-lspconfig
  packadd nvim-lsp-installer

  " treesitter
  packadd nvim-treesitter
  " packadd playground
  " packadd nvim-ts-rainbow
  " packadd vim-matchup
]])

require("settings")
require("colors")
require("autocmds")
require("plugins.lsp")
require("plugins.treesitter")

vim.defer_fn(function()
    require("plugins.dap")
    require("statusline")
    require("plugins.luasnip")
    require("plugins.cmp")
    require("plugins.autopairs")
    -- TODO
    -- - ./autoload/map/map.vim -> ./lua/keymap.lua
    require("keymap")
    -- require("zettels")

    vim.cmd([[
      runtime! lazy/plugins/*
      runtime! lazy/funcs/*
      runtime! lazy/autocmd/*
      runtime! lazy/command/*
      runtime! lazy/local/*
      silent! helptags ALL
    ]])
end, 150)

