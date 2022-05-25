-- require("impatient").enable_profile()
--
--
-- :lua= sth_to_print
-- :lua print(vim.inspect(sth_to_print))

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

require("impatient")
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
end, 200)
