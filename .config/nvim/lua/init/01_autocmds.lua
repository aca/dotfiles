local vim = vim

-- restore cursor position on start
-- (vim) silent! execute "normal! g`\""
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*" },
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- -- load dirvish on open if it's directory
-- vim.api.nvim_create_autocmd("BufEnter", {
--     callback = function()
--         -- if vim.fn.isdirectory(vim.fn.expand("%:p")) == 1 then
--         ---@diagnostic disable-next-line: missing-parameter
--         if vim.fn.isdirectory(vim.api.nvim_buf_get_name(0)) == 1 then
--             vim.cmd([[ 
--   packadd vim-dirvish
--   execute 'Dirvish %'
--   ]]         )
--         end
--     end,
-- })
