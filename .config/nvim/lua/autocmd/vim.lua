local group = vim.api.nvim_create_augroup("_vim", { clear = true })
local nvim_create_autocmd = vim.api.nvim_create_autocmd

-- nvim_create_autocmd("FileType", {
-- 	group = group,
-- 	pattern = { "vim" },
--     command = "echom loadedvim",
-- })
