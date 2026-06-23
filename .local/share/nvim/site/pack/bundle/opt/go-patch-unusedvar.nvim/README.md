# go-patch-unusedvar.nvim

Patch [UnusedVar error](https://github.com/golang/go/issues/43729)

```
x := 3 // Unused variable x
```

```
x := 3
_ = x 
```

Requires neovim native lsp client and treesitter.


## Setup

Run it with a command 

```
:GoPatchUnusedVar 
```


or

```
require("go-patch-unusedvar")()
```

or

With null-ls(none-ls), we can create codeaction for it.

```
vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("none-ls.nvim")
vim.cmd.packadd("go-patch-unusedvar.nvim")

require("null-ls").register({
	name = "go-patch-unusedvar",
	method = { require("null-ls").methods.CODE_ACTION },
	filetypes = { "go" },
	generator = {
		fn = function()
			local found = false
			for _, v in ipairs(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) do
				if v["code"] == "UnusedVar" then
					found = true
				end
			end

			if not found then
				return nil
			end

			return {
				{
					title = "patch unused vars",
					action = function()
						require("go-patch-unusedvar")()
					end,
				},
			}
		end,
	},
})
```

