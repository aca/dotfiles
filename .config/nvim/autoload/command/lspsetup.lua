vim.api.nvim_add_user_command("LspSetup", function()
    vim.cmd([[
  LspInstall 
   \ vimls
   \ html
   \ rust_analyzer@nightly
   \ tailwindcss
   \ bashls
   \ sumneko_lua
  ]])
end, {})
