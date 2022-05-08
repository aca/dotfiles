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
  end
end})

nvim_create_autocmd("BufNewFile", {
  group = group,
  -- pattern = { "~/src/zk/**.md"},
  pattern = { "**/src/zk/**.md"},
  command = [[
    execute "0r! ~/src/configs/dotfiles/.config/nvim/templates/zettels.sh" . ' ' . expand('%:t:r')
  ]]
})
--
--
