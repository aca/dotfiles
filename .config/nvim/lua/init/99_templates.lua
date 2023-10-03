-- templates, zk
--     nvim_create_autocmd("BufNewFile", {
--         group = group,
--         pattern = { "**/src/zk/**.md" },
--         command = [[
-- execute "0r! ~/.config/nvim/templates/zettels.sh" . ' ' . expand('%:t:r')
--     ]],
--     })

-- templates, gh actions
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = { "*.go" },
    command = [[ execute "0r! ~/.config/nvim/templates/go.sh" ]],
})
--
-- -- templates
-- nvim_create_autocmd("BufNewFile", {
--     pattern = { "**/.github/workflows/**.y*ml" },
--     command = [[ execute "0r! ~/.config/nvim/templates/gh-actions.sh" . ' ' . expand('%:t:r') ]],
-- })
