vim.cmd.packadd "fzf"
vim.cmd.packadd "fzf.vim"

-- vim.cmd([[ runtime! lua/core/fzf.vim ]])
-- FZF actions
vim.g.fzf_action = {
  ['ctrl-h'] = 'abort',
  ['ctrl-l'] = 'abort',
  ['ctrl-t'] = 'tab split',
  ['ctrl-s'] = 'split',
  ['ctrl-v'] = 'vsplit'
}

-- Autocommands for FZF
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fzf',
  callback = function()
    -- Store laststatus and set to 0
    local laststatus = vim.opt.laststatus:get()
    vim.opt.laststatus = 0
    
    -- Restore laststatus when leaving buffer
    vim.api.nvim_create_autocmd('BufLeave', {
      buffer = 0,
      callback = function()
        vim.opt.laststatus = laststatus
      end
    })
  end
})

-- Terminal mappings for FZF
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fzf',
  callback = function()
    vim.keymap.set('t', '<c-j>', '<c-j>', { buffer = true })
    vim.keymap.set('t', '<c-k>', '<c-k>', { buffer = true })
  end
})

-- FZF settings
vim.g.fzf_preview_window = {'right:50%:noborder', 'ctrl-w'}
vim.g.fzf_layout = {
  window = {
    width = 0.99,
    height = 0.8,
    relative = true
  }
}
vim.g.fzf_buffers_jump = 1 -- [Buffers] Jump to the existing window if possible

-- Key mappings
local opts = { silent = true }

vim.keymap.set('n', '<m-f>', ':RgWithFile<CR>', opts)
vim.keymap.set('v', '<c-f>', 'y:Rg <C-R>"<CR>', opts)
vim.keymap.set('n', '<c-f>', ':Rg<CR>', opts)
vim.keymap.set('n', '<Leader>fw', ':Rg <C-R><C-W><CR>', opts)
vim.keymap.set('n', '<Leader>fW', ':Rg <C-R><C-A><CR>', opts)
vim.keymap.set('v', '<Leader>fw', 'y:Rg <C-R>"<CR>', opts)
vim.keymap.set('n', '<Leader>fm', ':FZFMarks<CR>', opts)
vim.keymap.set('n', '<Leader>fl', ':BLines<CR>', opts)
vim.keymap.set('n', '<Leader>ff', ':Files<CR>', opts)
vim.keymap.set('n', '<Leader>fh', ':History<CR>', opts)
vim.keymap.set('n', "<Leader>'", ':FZFMarks<CR>', opts)
vim.keymap.set('n', '<Leader>b', ':Buffers<CR>', opts)
vim.keymap.set('n', '<Leader>fc', ':Commits<CR>', opts)

-- Rg command
vim.api.nvim_create_user_command("Rg", function(opts)
  -- If the command is invoked with !, opts.bang is true.
  local bang = opts.bang and "1," or ""
  -- Get and escape the command arguments
  local escaped_args = vim.fn.shellescape(opts.args)
  local cmd = "rg -L --line-number --color=always --no-heading  --smart-case -- 2>/dev/null " .. escaped_args
  -- Construct preview options, where the bang determines the '--nth' value
  local preview_opts = { options = "--delimiter : --nth " .. bang .. "3.. " }
  local preview = vim.fn["fzf#vim#with_preview"](preview_opts)
  vim.fn["fzf#vim#grep"](cmd, 1, preview, 0)
end, { bang = true, nargs = "*" })
