-- vim.cmd.packadd "markview.nvim"
vim.cmd.packadd "live-preview.nvim"
require('livepreview.config').set()

vim.o.conceallevel = 0


-- https://github.com/wookayin/dotfiles/blob/9fe85278869d3fde63e140598e2b0896bfb4fdd1/nvim/after/ftplugin/markdown.lua#L20-L42
-- -- GFM markdown preview using grip
-- -- (pip install grip)
-- vim.api.nvim_buf_create_user_command(0, 'Grip', function(opts)
--   local win = vim.api.nvim_get_current_win()
--   local exitcode = nil
--   vim.cmd [[ botright 7new ]]
--   vim.cmd [[ setlocal winfixheight ]]
--   vim.fn.termopen({ "grip", vim.fn.expand('%'), "0.0.0.0" }, {
--     on_exit = function(job_id, data, event)
--       exitcode = data
--     end,
--   })
--   vim.api.nvim_set_current_win(win)
--   vim.cmd.stopinsert()  -- workaround for autocmd+terminal bug
--
--   if vim.ui.open and os.getenv('SSH_CONNECTION') == nil then
--     vim.defer_fn(function()
--       if exitcode == nil or exitcode == 0 then
--         vim.ui.open('http://localhost:6419/')
--       end
--     end, 200)
--   end
-- end, { nargs = 0 })
