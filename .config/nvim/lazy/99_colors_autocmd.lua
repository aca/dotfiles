vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "Statusline", { bg = "#0D0D0D" })
		vim.api.nvim_set_hl(0, "LineNr", { bg = "none", fg = "#3e3e3e" })

		vim.api.nvim_set_hl(0, "BufTabLineCurrent", { bg = "#0D0D0D", fg = "#d7d4d4", bold = true })
		vim.api.nvim_set_hl(0, "BufTabLineActive", { bg = "#0D0D0D", fg = "#d7d4d4", italic = true })
		vim.api.nvim_set_hl(0, "BufTabLineHidden", { bg = "#0D0D0D", fg = "#4e4e4e", italic = true })
		vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#0D0D0D", fg = "#d7d4d4" })
	end,
})
