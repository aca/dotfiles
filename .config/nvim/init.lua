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
require("impatient")
-- require("impatient").enable_profile()

require("globals")
require("vim")
require("plugins.treesitter")
vim.loop.new_timer():start(
    0,
    0,
    vim.schedule_wrap(function()
        require("plugins.autopairs")
        require("plugins.luasnip")
        require("plugins.lsp")
        require("plugins.cmp")
        -- require("plugins.dap")

        cmd([[
      runtime! autoload/plugin/*
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

vim.cmd [[
if executable('ugrep')
    set grepprg=ugrep\ -RInk\ -j\ -u\ --tabs=1\ --ignore-files
    set grepformat=%f:%l:%c:%m,%f+%l+%c+%m,%-G%f\\\|%l\\\|%c\\\|%m
endif
]]
