if vim.uv.available_parallelism() <= 4 then
	return
else
	vim.cmd.packadd("nvim.undotree")
	vim.cmd.packadd("nvim.difftool")
end
