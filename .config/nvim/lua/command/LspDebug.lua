local vim = vim
vim.api.nvim_create_user_command("LspDebug", function()
    vim.lsp.set_log_level("debug")
    require("vim.lsp.log").set_format_func(vim.inspect)
end, {})
