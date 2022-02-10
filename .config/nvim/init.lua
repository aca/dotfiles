
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

require("impatient") -- https://github.com/lewis6991/impatient.nvim
-- require("impatient").enable_profile()


require("globals")
require("vim")
if not g._minimal then
    require("plugins.lsp")
    require("plugins.treesitter")
end

vim.loop.new_timer():start(
    50,
    0,
    vim.schedule_wrap(function()
        require("plugins.tmux")
        require("plugins.hop")

        if not g._minimal then
            require("plugins.luasnip")
            require("plugins.autopairs")
            require("plugins.cmp")
            require("plugins.buftabline")
            require("plugins.oscyank")

            require("plugins.gitlinker")
            -- require("plugins.octo")
            require("plugins.git-messenger")
            require("plugins.gitsigns")

            require("plugins.comment")
            -- require("plugins.dap")
            -- require("plugins.vim-test") -- TODO: replace
            -- require("plugins.matchparen") -- TODO: fix
            -- require("plugins.telescope")
        end

        cmd([[
      runtime! autoload/plugin/*
      runtime! autoload/func/*
      runtime! autoload/autocmd/*
      runtime! autoload/command/*
      runtime! autoload/map/*
      runtime! autoload/lib/*
      runtime! autoload/local/*
      ]])
    end)
)
