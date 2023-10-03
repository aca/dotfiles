vim.api.nvim_create_autocmd("BufWritePost", {
    -- pattern = vim.fn.expand("~") .. "/.config/nvim/lua/init/*.lua",
    pattern = "**/.config/nvim/lua/init/*.lua",
	callback = function()
        vim.api.nvim_exec([[
call system(["bash", "-c", "make -C ~/.config/nvim build_init_lua"])
        ]], true)
        print("build")
	end,
})
