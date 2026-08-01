vim.pack.add({ { src = 'https://github.com/folke/lazy.nvim' } })
vim.pack.add({ { src = 'https://github.com/folke/lazydev.nvim.git' } })
require("lazydev").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
})
