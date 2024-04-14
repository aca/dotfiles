local nvim_create_autocmd = vim.api.nvim_create_autocmd
nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.o.tabline = " %t %{%v:lua.dropbar.get_dropbar_str()%}"
	end,
})

nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
        vim.o.tabline="%!buftabline#render()"
	end,
})
