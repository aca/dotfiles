local group = vim.api.nvim_create_augroup("_defaults", { clear = true })
local nvim_create_autocmd = vim.api.nvim_create_autocmd

-- if there's no other window but quickfix close vim
nvim_create_autocmd("WinEnter", {
  group = group,
  pattern = {"*"},
  command = 'au WinEnter * if winnr(\'$\') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif'
})

nvim_create_autocmd("TermOpen", {
  group = group,
  pattern = {"*"},
  command = 'startinsert'
})

nvim_create_autocmd("TextYankPost", {
  group = group,
  pattern = {"*"},
  callback = function()
    vim.highlight.on_yank()
  end
})

-- nvim_create_autocmd("QuickFixCmdPost", {
--   group = group,
--   command = "cgetexpr cwindow"
-- })
--
-- nvim_create_autocmd("QuickFixCmdPost", {
--   group = group,
--   command = "cgetexpr setlocal ft=qf"
-- })
