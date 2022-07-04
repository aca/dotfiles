local group = vim.api.nvim_create_augroup("_go", { clear = true })
local nvim_create_autocmd = vim.api.nvim_create_autocmd

nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = {"*.go"},
  callback = function()
    vim.lsp.buf.code_action({apply=true, filter=function(action) return action.title == 'Organize Imports' end})
  end
})
