vim.cmd.packadd("betterTerm.nvim")
vim.cmd.packadd("code_runner.nvim")

require("code_runner").setup({
	filetype = {
		java = {
			"cd $dir &&",
			"javac $fileName &&",
			"java $fileNameWithoutExt",
		},
		python = "python3 -u",
		typescript = "deno run",
		nix = "nix-instantiate --strict --eval",
		rust = {
			"cd $dir &&",
			"rustc $fileName &&",
			"$dir/$fileNameWithoutExt",
		},
		c = function(...)
			c_base = {
				"cd $dir &&",
				"gcc $fileName -o",
				"/tmp/$fileNameWithoutExt",
			}
			local c_exec = {
				"&& /tmp/$fileNameWithoutExt &&",
				"rm /tmp/$fileNameWithoutExt",
			}
			vim.ui.input({ prompt = "Add more args:" }, function(input)
				c_base[4] = input
				vim.print(vim.tbl_extend("force", c_base, c_exec))
				require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
			end)
		end,
	},
})
