vim.pack.add({ { src = 'https://github.com/willothy/flatten.nvim' } })
require("flatten").setup()

vim.defer_fn(function()
require("lazy")
end, 20)
