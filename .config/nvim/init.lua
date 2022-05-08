-- TODO
-- lazy loading tricks https://github.com/ray-x/nvim/blob/master/lua/core/lazy.lua
-- https://github.com/shaunsingh/nyoom.nvim
-- https://github.com/stevearc/stickybuf.nvim
-- https://www.reddit.com/r/neovim/comments/ts8app/what_are_the_must_have_git_plugs_in_your_opinion/
-- https://github.com/willchao612/vim-diagon
-- https://www.reddit.com/r/neovim/comments/sihuq7/psa_now_you_can_set_global_highlight_groups_ie/
-- https://github.com/frabjous/knap
-- https://github.com/michaelb/sniprun
-- https://www.reddit.com/r/neovim/comments/p206ju/magmanvim_interact_with_jupyter_from_neovim/
-- https://github.com/dccsillag/magma-nvim

-- UPDATE [[
-- :TSInstall all
-- :TSUpdate all
-- :LspUpdateAll
-- ]]

-- TODO: zettels related

-- https://github.com/lewis6991/impatient.nvim
-- require("impatient").enable_profile()
require("impatient")
require("vim")
require("colors")
require("plugins.lsp")
require("plugins.treesitter")

vim.defer_fn(function()
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
      runtime! autoload/plugins/*
      runtime! autoload/utils/*
      runtime! autoload/autocmd/*
      runtime! autoload/command/*
      runtime! autoload/map/* 
      runtime! autoload/local/*
      silent! helptags ALL 
    ]])
end, 100)
