vim.api.nvim_create_user_command("LspSetup", function()
	vim.cmd([[
  LspInstall
   \ vimls
   \ html
   \ rust_analyzer@nightly
   \ bashls
   \ sumneko_lua
  ]])
end, {})
