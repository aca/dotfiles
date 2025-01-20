vim.o.expandtab = false

local tmux_split_and_go_run = function()
  local pane_id = vim.fn.system('tmux split-window -d -P -F "#{pane_id}"')
  pane_id = vim.trim(pane_id)
  -- vim.fn.system("tmux send-keys 'clear; go run .' Enter")
  local send_cmd = "tmux send-keys -t " .. pane_id .. " '" .. "clear; go run ." .. "' Enter"
  vim.fn.system(send_cmd)
end

vim.keymap.set("n", "<leader>rr", tmux_split_and_go_run, { noremap = true, silent = true })

