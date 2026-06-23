-- templates, zk
--     nvim_create_autocmd("BufNewFile", {
--         group = group,
--         pattern = { "**/src/zk/**.md" },
--         command = [[
-- execute "0r! ~/.config/nvim/templates/zettels.sh" . ' ' . expand('%:t:r')
--     ]],
--     })

-- package name at start
-- TODO: main pkg doesn't work
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = { "main.go" },
    -- pass dirname
    command = [[ 
    execute "0r! ~/.config/nvim/templates/go-main.sh"
    normal k
    ]],
})

-- -- templates
-- nvim_create_autocmd("BufNewFile", {
--     pattern = { "**/.github/workflows/**.y*ml" },
--     command = [[ execute "0r! ~/.config/nvim/templates/gh-actions.sh" . ' ' . expand('%:t:r') ]],
-- })
