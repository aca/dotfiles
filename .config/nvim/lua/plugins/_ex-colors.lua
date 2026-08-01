if vim.uv.available_parallelism() > 4 then
    vim.pack.add({ { src = 'https://github.com/aileot/ex-colors.nvim.git' } })
    require("ex-colors").setup()
end

