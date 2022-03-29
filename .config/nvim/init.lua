--
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

-- https://github.com/lewis6991/impatient.nvim
-- require("impatient").enable_profile()
require("impatient")
require("globals")
require("vim")
require("plugins.treesitter")
require("plugins.lsp")
vim.loop.new_timer():start(
    100,
    0,
    vim.schedule_wrap(function()
        -- require("plugins.dap")
        require("luasnip")
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
      " helptags ALL
      ]])
    end)
)

-- local augroup_init = vim.api.nvim_create_augroup("init", {
--     clear = false,
-- })
--
-- vim.api.nvim_create_autocmd("InsertEnter", {
--     group = augroup_init,
--     pattern = "*",
--     callback = function()
--         require("plugins.autopairs")
--     end,
-- })
