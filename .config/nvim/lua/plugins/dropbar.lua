vim.cmd.packadd("dropbar.nvim")
require("dropbar").setup({
    general = { enable = false },
    -- icons = { enable = false },
	bar = {
		sources = function(buf, _)
			local sources = require("dropbar.sources")
			local utils = require("dropbar.utils")
			local ft = vim.bo[buf].ft
			if vim.bo[buf].buftype == "terminal" then
				return {
					-- sources.terminal,
				}
			elseif vim.treesitter.language.get_lang(ft) == nil then
				return {
					sources.path,
				}
			end
			return {
				-- sources.path,
				utils.source.fallback({
					sources.treesitter,
					sources.markdown,
					sources.lsp,
				}),
			}
		end,
		padding = {
			left = 1,
			right = 1,
		},
		-- pick = {
		--   pivots = 'abcdefghijklmnopqrstuvwxyz',
		-- },
		truncate = true,
	},
})

-- -- vim.o.winbar = "%{%v:lua.dropbar.get_dropbar_str()%}"
vim.o.statusline = "%t %{%v:lua.dropbar.get_dropbar_str()%}"
-- -- vim.opt.winbar = ""
