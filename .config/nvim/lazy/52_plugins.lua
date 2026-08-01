vim.pack.add({ { src = 'https://github.com/nvim-lua/plenary.nvim.git' } })
-- vim.pack.add({ { src = 'https://github.com/IndianBoy42/tree-sitter-just.git' } })
vim.pack.add({ { src = 'https://github.com/justinmk/vim-dirvish.git' } })
vim.pack.add({ { src = 'https://github.com/inkarkat/vim-ReplaceWithRegister.git' } })
vim.pack.add({ { src = 'https://github.com/tpope/vim-eunuch.git' } })

-- quickfix improvement
-- vim.pack.add({ { src = 'https://github.com/stefandtw/quickfix-reflector.vim.git' } })
vim.pack.add({ { src = 'https://github.com/stevearc/quicker.nvim' } })
require("quicker").setup()

vim.cmd.packadd("vim-dirdiff")

-- this cause slowdown on large file
-- vim.pack.add({ { src = 'https://github.com/mcauley-penney/visual-whitespace.nvim' } })
-- require("visual-whitespace")

-- vim.pack.add({ { src = 'https://github.com/catgoose/nvim-colorizer.lua.git' } })
-- require("colorizer").setup()

-- vim.cmd.packadd("nvim-luadev")
--
-- vim.cmd [[ 
-- nmap <leader>r <Plug>(Luadev-RunLine)
-- ]]



-- vim.pack.add({ { src = 'https://github.com/jake-stewart/auto-cmdheight.nvim' } })
-- require("auto-cmdheight").setup({
--     max_lines = 10,
--     duration = 2,
--     remove_on_key = true,
--     clear_always = false,
-- })

vim.cmd([[
        runtime! lua/plugins/*
        runtime! lua/command/*
        runtime! lua/autocmd/*
        runtime! local/*
        runtime! lua/dev/*
        runtime! lua/dev/gofix/*
]])

vim.cmd([[
" vim-swap
let g:swap_no_default_key_mappings = 1
lua vim.pack.add({ { src = 'https://github.com/machakann/vim-swap.git' } })
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
]])

-- navigate
-- vim.opt.isfname:append(":")
-- vim.cmd([[
-- " https://github.com/wsdjeg/vim-fetch/issues/27
-- lua vim.pack.add({ { src = 'https://github.com/wsdjeg/vim-fetch.git' } }) " TODO: replace or mv to start
-- ]])
vim.pack.add({ { src = 'https://github.com/lewis6991/fileline.nvim.git' } })

vim.cmd([[
let g:nf_map_next=']f'
let g:nf_map_previous='[f'
lua vim.pack.add({ { src = 'https://github.com/tyru/nextfile.vim.git' } })
lua vim.pack.add({ { src = 'https://github.com/justinmk/vim-dirvish.git' } })
]])

-- etc
vim.cmd([[
imap <silent><c-d> <c-r>=strftime("## %Y-%m-%d %a %H:%M:%S %Z")<cr><cr>
]])

-- vim.pack.add({ { src = 'https://github.com/folke/which-key.nvim' } })
-- require("which-key").setup({
--     preset = "helix",
-- })
-- require("which-key").show({ global = false })
