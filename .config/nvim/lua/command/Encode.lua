vim.api.nvim_create_user_command("EncodeEUCKR", function(msg)
    vim.cmd [[ :e ++enc=euc-kr ]]
end, {})
