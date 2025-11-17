-- https://www.reddit.com/r/neovim/comments/re07pk/close_neovim_if_last_buffer/
-- TODO: replace with lua
-- not sure what this does
vim.cmd.packadd("nvim-bufdel")

-- Smart “close-or-quit” helper
local function smart_close()
  -- Close quickfix or loclist window if it’s on screen
  local function close_special(kind, cmd)
    for _, win in ipairs(vim.fn.getwininfo()) do
      if win[kind] == 1 then
        vim.cmd(cmd)       -- cclose / lclose
        return true        -- we’re done for this call
      end
    end
    return false
  end

  if close_special("quickfix", "cclose") then return end
  if close_special("loclist", "lclose")  then return end

  -- Count listed (normal) buffers
  local listed = vim.fn.getbufinfo({ buflisted = 1 })
  if #listed > 1 then
    vim.cmd("bdelete!")      -- just close the current buffer
  else
    vim.cmd("quit!")         -- last one → leave Neovim
  end
end

vim.keymap.set("n", "<c-q>", smart_close, { desc = "Smart close/quit" })
vim.keymap.set("i", "<c-q>", smart_close, { desc = "Smart close/quit" })
vim.keymap.set("v", "<c-q>", smart_close, { desc = "Smart close/quit" })
