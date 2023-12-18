local vim = vim

-- restore cursor position on start
vim.api.nvim_create_autocmd("BufReadPost", { command = [[
    silent! execute "normal! g`\""
]]})


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
