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
      runtime! autoload/utils/*
      runtime! autoload/autocmd/*
      runtime! autoload/command/*
      runtime! autoload/map/* 
      runtime! autoload/lib/*
      runtime! autoload/local/*
      silent! helptags ALL 
    ]])
end, 100)


-- vim.diagnostic._get_virt_text_chunks(line_diags, opts)
--   if #line_diags == 0 then
--     return nil
--   end
--
--   opts = opts or {}
--   local prefix = opts.prefix or "■"
--   local spacing = opts.spacing or 4
--
--   -- Create a little more space between virtual text and contents
--   local virt_texts = {{string.rep(" ", spacing)}}
--
--   for i = 1, #line_diags - 1 do
--     table.insert(virt_texts, {prefix, vim.diagnostic.virtual_text_highlight_map[line_diags[i].severity]})
--   end
--   local last = line_diags[#line_diags]
--
--   -- TODO(tjdevries): Allow different servers to be shown first somehow?
--   -- TODO(tjdevries): Display server name associated with these?
--   if last.message then
--     table.insert(
--       virt_texts,
--       {
--         string.format("%s %s", prefix, last.message:gsub("\r", ""):gsub("\n", "  ")),
--         virtual_text_highlight_map[last.severity]
--       }
--     )
--
--     return virt_texts
--   end
