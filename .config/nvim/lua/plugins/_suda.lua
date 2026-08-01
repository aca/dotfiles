vim.pack.add({ { src = 'https://github.com/lambdalisue/suda.vim.git' } })
vim.api.nvim_create_user_command('SudoWrite', 'SudaWrite', {})
vim.api.nvim_create_user_command('SudoRead', 'SudaRead', {})
