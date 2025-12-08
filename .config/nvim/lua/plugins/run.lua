vim.api.nvim_create_user_command("Run", function(args)
	vim.cmd("vertical terminal sh -c '" .. args.args .. "; elvish'")
end, {
	nargs = "*",
	-- complete = "command",
	range = true,
	bang = true,
})
