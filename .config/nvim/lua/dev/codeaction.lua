vim.keymap.set("n", ";af", function()
	vim.lsp.buf.code_action({
		filter = function(action)
			return action.title and action.title:match("Fill")
		end,
		apply = true, -- Automatically apply if only one action matches
	})
end, { desc = "Run 'Fill struct' code action" })
