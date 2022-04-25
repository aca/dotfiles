-- TODO
-- lazy loading tricks https://github.com/ray-x/nvim/blob/master/lua/core/lazy.lua
-- https://github.com/shaunsingh/nyoom.nvim
-- https://github.com/stevearc/stickybuf.nvim
-- https://www.reddit.com/r/neovim/comments/ts8app/what_are_the_must_have_git_plugs_in_your_opinion/
-- https://github.com/willchao612/vim-diagon
-- https://www.reddit.com/r/neovim/comments/sihuq7/psa_now_you_can_set_global_highlight_groups_ie/
-- https://github.com/frabjous/knap

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

-- TODO
-- - ./autoload/map/map.vim -> ./lua/keymap.lua

local g = vim.g
local cmd = vim.cmd
local defer_fn = vim.defer_fn

-- https://github.com/lewis6991/impatient.nvim
-- require("impatient").enable_profile()
require("impatient")
require("vim")
require("colors")
require("plugins.lsp")
require("plugins.treesitter")

defer_fn(function()
    -- require("plugins.dap")
    require("plugins.luasnip")
    require("plugins.cmp")
    require("plugins.autopairs")
    require("keymap")

    cmd([[
      runtime! autoload/plugins/*
      runtime! autoload/func/*
      runtime! autoload/autocmd/*
      runtime! autoload/command/*
      runtime! autoload/map/* 
      runtime! autoload/lib/*
      runtime! autoload/local/*
      silent! helptags ALL 
    ]])
end, 100)
