-- qq to record, Q to replay
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("x", "Q", ":norm @q<cr>")

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    vim.notify("Recording macro @" .. vim.fn.reg_recording(), vim.log.levels.WARN)
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    vim.notify("Stopped recording @" .. vim.fn.reg_recording(), vim.log.levels.INFO)
  end,
})
