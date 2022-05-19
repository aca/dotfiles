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
-- https://www.reddit.com/r/neovim/comments/um3epn/what_are_your_prizedfavorite_lua_functions/

-- require("impatient").enable_profile()
--
--
-- :lua= sth_to_print
-- :lua print(vim.inspect(sth_to_print))

require("impatient")
require("settings")
require("colors")
require("autocmds")
require("plugins.lsp")
require("plugins.treesitter")

vim.cmd [[

function! g:OpenNewWindow(url)
    exe 'open -na "Google Chrome" ' . a:url
endfunction
let g:mkdp_browserfunc = 'g:OpenNewWindow'

" let g:mkdp_browser = '/Applications/Firefox.app/Contents/MacOS/firefox-bin'
packadd markdown-preview.nvim
]]

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
      runtime! lazy/plugins/*
      runtime! lazy/funcs/*
      runtime! lazy/autocmd/*
      runtime! lazy/command/*
      runtime! lazy/local/*
      silent! helptags ALL 
    ]])
end, 100)


local diagnostics_active = true
vim.keymap.set('n', '<leader>d', function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end)
