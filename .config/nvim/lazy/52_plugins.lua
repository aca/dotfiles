vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("tree-sitter-just")
vim.cmd.packadd("vim-dirvish")
vim.cmd.packadd("quickfix-reflector.vim")
vim.cmd.packadd("vim-ReplaceWithRegister")
vim.cmd.packadd("vim-eunuch")

vim.cmd.packadd("visual-whitespace.nvim")
require("visual-whitespace")

-- vim.cmd.packadd("nvim-colorizer.lua")
-- require("colorizer").setup()


-- vim.cmd.packadd("nvim-luadev")
--
-- vim.cmd [[ 
-- nmap <leader>r <Plug>(Luadev-RunLine)
-- ]]



-- vim.cmd.packadd 'auto-cmdheight.nvim'
-- require("auto-cmdheight").setup({
--     max_lines = 10,
--     duration = 2,
--     remove_on_key = true,
--     clear_always = false,
-- })

vim.cmd([[
        runtime! lua/plugins/*
        runtime! lua/plugins-unstable/*
        runtime! lua/command/*
        runtime! lua/autocmd/*
        runtime! local/*
        runtime! lua/dev/*
]])

vim.cmd([[
" vim-swap
let g:swap_no_default_key_mappings = 1
packadd vim-swap
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
]])

-- navigate
vim.cmd([[
packadd vim-fetch " TODO: replace or mv to start

let g:nf_map_next=']f'
let g:nf_map_previous='[f'
packadd nextfile.vim
packadd vim-dirvish
]])

-- etc
vim.cmd([[
imap <silent><c-d> <c-r>=strftime("## %Y-%m-%d %a %H:%M:%S %Z")<cr><cr>
]])

-- vim.cmd.packadd("which-key.nvim")
-- require("which-key").setup({
--     preset = "helix",
-- })
-- require("which-key").show({ global = false })
