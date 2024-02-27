vim.diagnostic.config({
	-- virtual_text = { prefix = "", format = rightAlignFormatFunction, spacing = 0, update_in_insert = true },
	virtual_text = false,
	float = {
		source = "always", -- Or "if_many"
	},
	-- float = { border = "rounded" },
})
