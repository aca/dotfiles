-- TODO: lazy loading tricks https://github.com/ray-x/nvim/blob/master/lua/core/lazy.lua
-- TODO: https://github.com/shaunsingh/nyoom.nvim
-- TODO: https://github.com/akinsho/git-conflict.nvim
-- TODO: https://github.com/stevearc/stickybuf.nvim
--
-- DEBUG [[
-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)
-- ]]

-- UPDATE [[
-- :TSInstall all
-- :TSUpdate all
-- :LspUpdateAll
-- ]]

-- TODO: jupyter integration
-- https://www.reddit.com/r/neovim/comments/p206ju/magmanvim_interact_with_jupyter_from_neovim/
-- https://github.com/dccsillag/magma-nvim

-- TODO: zettels related
-- require 'zettels'

local vim = vim
local g = vim.g
local cmd = vim.cmd
local defer_fn = vim.defer_fn

-- https://github.com/lewis6991/impatient.nvim
-- require("impatient").enable_profile()
require("impatient")
require("vim")
require("plugins.treesitter")
require("plugins.lsp")

defer_fn(function()
    -- require("plugins.dap")
    require("plugins.luasnip")
    require("plugins.cmp")
    require("plugins.autopairs")

    cmd([[
      runtime! autoload/plugins/*
      runtime! autoload/func/*
      runtime! autoload/autocmd/*
      runtime! autoload/command/*
      runtime! autoload/map/*
      runtime! autoload/lib/*
      runtime! autoload/local/*
    ]])
end, 30)

defer_fn(function()
    cmd([[ 
    silent! helptags ALL 
  ]])
end, 300)
