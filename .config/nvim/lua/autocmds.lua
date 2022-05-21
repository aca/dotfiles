local group = vim.api.nvim_create_augroup("init", { clear = true })
local nvim_create_autocmd = vim.api.nvim_create_autocmd

-- restore cursor position on start
nvim_create_autocmd("BufReadPost", { command = [[ 
silent! exe "normal! g`\"" 
]], group = group })

-- set commentstring to '#' by default
nvim_create_autocmd({"BufWinEnter", "BufAdd"}, { group = group , callback = function()
  if vim.bo.filetype == "" then
    vim.bo.commentstring = "# %s"
  elseif vim.bo.filetype == "elvish" then
    vim.bo.commentstring = "# %s"
  end
end})

-- templates, zk
nvim_create_autocmd("BufNewFile", {
  group = group,
  pattern = { "**/src/zk/**.md"},
  command = [[
    execute "0r! ~/src/configs/dotfiles/.config/nvim/templates/zettels.sh" . ' ' . expand('%:t:r')
  ]]
})

-- templates, gh actions
nvim_create_autocmd("BufNewFile", {
  group = group,
  pattern = { "**/.github/workflows/**.y*ml" },
  command = [[
    execute "0r! ~/src/configs/dotfiles/.config/nvim/templates/gh-actions.sh" . ' ' . expand('%:t:r')
  ]]
})
