local vim = vim

-- restore cursor position on start
-- (vim) silent! execute "normal! g`\""
-- https://github.com/neovim/neovim/issues/16339#issuecomment-1519107163
-- vim.api.nvim_create_autocmd("BufRead", {
-- 	callback = function(opts)
-- 		vim.api.nvim_create_autocmd("BufWinEnter", {
-- 			once = true,
-- 			buffer = opts.buf,
-- 			callback = function()
-- 				local ft = vim.bo[opts.buf].filetype
-- 				local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
-- 				if
-- 					not (ft:match("commit") and ft:match("rebase"))
-- 					and last_known_line > 1
-- 					and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
-- 				then
-- 					vim.api.nvim_feedkeys([[g`"]], "nx", false)
-- 				end
-- 			end,
-- 		})
-- 	end,
-- })

if vim.fn.isdirectory(vim.api.nvim_buf_get_name(0)) == 1 then
	vim.cmd([[ 
  packadd vim-dirvish
  execute 'Dirvish %'
  ]])
end

-- -- load dirvish on open if it's directory, or lazyload
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	callback = function()
-- 		if vim.fn.isdirectory(vim.api.nvim_buf_get_name(0)) == 1 then
-- 			vim.cmd([[
--   packadd vim-dirvish
--   execute 'Dirvish %'
--   ]])
-- 		end
-- 	end,
-- })
