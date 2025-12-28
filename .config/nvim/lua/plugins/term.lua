-- https://github.com/neovim/neovim/issues/27561
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function(args)
    local dirty_buf_enter = false
    local bufnr = args.buf
    -- Triggers the following sequence of events after resizing or opening the terminal buffer:
    -- Resize the terminal to 0 width and 0 height
    -- Wait 50ms
    -- Resize the terminal to 100 width and 100 height
    -- Switch to a temporary buffer and switch back
    -- Resize the terminal to 0 width and 0 height
    -- Wait 50ms
    -- Resize the terminal to 100 width and 100 height
    -- Terminal looks good
    local function correct_size()
      local temp_bufnr = vim.api.nvim_create_buf(false, true)
      vim.cmd('resize 0 0')
      local cur_dirty_buf_enter = dirty_buf_enter
      vim.defer_fn(function()
        vim.cmd('resize 100 100')
        if not cur_dirty_buf_enter then
          dirty_buf_enter = true
          vim.api.nvim_set_current_buf(temp_bufnr)
          vim.api.nvim_set_current_buf(bufnr)
          vim.api.nvim_buf_delete(temp_bufnr, { force = true })
        end
      end, 50)
      if dirty_buf_enter then
        dirty_buf_enter = false
      end
    end
    vim.api.nvim_create_autocmd('BufEnter', {
      buffer = bufnr,
      callback = function()
        correct_size()
      end,
    })
    vim.api.nvim_create_autocmd('VimResized', {
      buffer = bufnr,
      callback = function()
        correct_size()
      end,
    })
  end,
})
