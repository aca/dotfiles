
-- Simple Neovim plugin to run commands in tmux split pane
local M = {}

-- Find the closest Go test function name using treesitter
function M.find_closest_test()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  local parser = vim.treesitter.get_parser(bufnr, 'go')
  local tree = parser:parse()[1]
  local cursor_node = tree:root():named_descendant_for_range(row, col, row, col)

  if not cursor_node then
    return nil
  end

  -- Walk up the tree to find a function declaration
  local current = cursor_node
  while current do
    if current:type() == 'function_declaration' then
      -- Get the function name
      local name_node = current:field('name')[1]
      if name_node then
        local name = vim.treesitter.get_node_text(name_node, bufnr)
        -- Check if it's a test function (starts with Test)
        if name:match('^Test') then
          return name
        end
      end
    end
    current = current:parent()
  end

  return nil
end

-- Run command in neovim terminal
function M.run_in_terminal(cmd)
  -- Create a vertical split with terminal
  vim.cmd('vsplit')
  vim.cmd('terminal elvish')

  -- Get the terminal buffer's channel
  local chan = vim.bo.channel

  -- Send the command
  vim.fn.chansend(chan, cmd .. '\n')
end

-- Run command in tmux split pane
function M.run_in_tmux(cmd)
  local cwd = vim.fn.getcwd()

  -- Create pane if it doesn't exist, or reuse existing one
  vim.fn.system("tmux split-window -h -c '" .. cwd .. "' || true")

  -- Send the command to the pane
  vim.fn.system("tmux send-keys -t 1 '" .. cmd .. "' Enter")
end

-- Run go test in neovim terminal
function M.go_test(test_name)
  -- Auto-detect test name if not provided
  if not test_name or test_name == "" then
    test_name = M.find_closest_test()
  end

  local cmd = "go test -v -run"
  if test_name and test_name ~= "" then
    cmd = cmd .. " " .. test_name
  end
  M.run_in_terminal(cmd)
end

-- Setup function to register commands
function M.setup()
  -- Command to run go test with optional test name
  vim.api.nvim_create_user_command('GoTest', function(opts)
    M.go_test(opts.args)
  end, { nargs = '?' })

  -- -- Generic command to run any command in neovim terminal
  -- vim.api.nvim_create_user_command('TermRun', function(opts)
  --   M.run_in_terminal(opts.args)
  -- end, { nargs = 1 })
  --
  -- -- Generic command to run any command in tmux split
  -- vim.api.nvim_create_user_command('TmuxRun', function(opts)
  --   M.run_in_tmux(opts.args)
  -- end, { nargs = 1 })
end

M.setup()
-- return M
