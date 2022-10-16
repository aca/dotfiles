local group = vim.api.nvim_create_augroup("_init", { clear = true })
local nvim_create_autocmd = vim.api.nvim_create_autocmd

--     -- restore cursor position on start
--     nvim_create_autocmd("BufReadPost", { command = [[ 
--     silent! exe "normal! g`\"" 
-- ]], group = group })

    -- templates, zk
--     nvim_create_autocmd("BufNewFile", {
--         group = group,
--         pattern = { "**/src/zk/**.md" },
--         command = [[
-- execute "0r! ~/.config/nvim/templates/zettels.sh" . ' ' . expand('%:t:r')
--     ]],
--     })

-- templates, gh actions
nvim_create_autocmd("BufNewFile", {
    group = group,
    pattern = { "**/.github/workflows/**.y*ml" },
    command = [[
execute "0r! ~/.config/nvim/templates/gh-actions.sh" . ' ' . expand('%:t:r')
]],
})

-- load dirvish on open if it's directory
nvim_create_autocmd("BufEnter", {
    group = group,
    callback = function()
        -- if vim.fn.isdirectory(vim.fn.expand("%:p")) == 1 then
        ---@diagnostic disable-next-line: missing-parameter
        if vim.fn.isdirectory(vim.api.nvim_buf_get_name(0)) == 1 then
            vim.cmd([[ 
  packadd vim-dirvish
  execute 'Dirvish %'
  ]])
        end
    end,
})

