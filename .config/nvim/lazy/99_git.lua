vim.pack.add({ { src = 'https://github.com/tpope/vim-fugitive.git' } })
vim.pack.add({ { src = 'https://github.com/TimUntersberger/neogit.git' } })

vim.pack.add({ { src = 'https://github.com/lewis6991/gitsigns.nvim.git' } })

require("gitsigns").setup()
