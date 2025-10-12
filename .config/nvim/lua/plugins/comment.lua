vim.cmd.packadd 'mini.nvim'
-- vim.cmd.packadd 'nvim-ts-context-commentstring'

require('mini.comment').setup({
  -- options = {
  --   custom_commentstring = function()
  --     return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
  --   end,
  -- },
})
