# nvim-contextline

Get simple context information using treesitter.
Replacement of [nvim-navic](https://github.com/SmiteshP/nvim-navic). 
Instead of using LSP, which always requires server implementation. It uses treesitter to show the current context.

Usage
```lua
vim.cmd.packadd('nvim-contextline')
vim.o.statusline = "%{%v:lua.require('nvim-contextline').get_context()%}%=%f"
```
