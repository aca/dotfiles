vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = vim.fn.expand("~") .. "/src/config/dotfiles/.config/nvim/lua/init/*.lua",
	callback = function()
        vim.api.nvim_exec([[
call system(["bash", "-c", "make -C ~/.config/nvim build_init_lua"])
        ]], true)
	end,
})
