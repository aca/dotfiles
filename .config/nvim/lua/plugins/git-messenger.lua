if vim.g._minimal then
	return
end

vim.cmd([[
  packadd git-messenger.vim
  nnoremap gm :GitMessenger<cr>
]])
