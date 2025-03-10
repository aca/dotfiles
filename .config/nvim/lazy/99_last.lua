vim.defer_fn(function()
	vim.cmd([[ silent! helptags ALL ]])
end, 100)
