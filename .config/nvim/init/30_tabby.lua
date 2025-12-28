vim.cmd.packadd("tabby.nvim")
vim.cmd.packadd("mini.nvim")

vim.o.showtabline = 1

-- function intToRoman(n)
-- 	local romans = {
-- 		"一",
-- 		"二",
-- 		"三",
-- 		"四",
-- 		"五",
-- 		"六",
-- 		"七",
-- 		"八",
-- 		"九",
-- 		"十",
-- 	}
-- 	return romans[n]
-- end

local theme = {
	fill = "TabLineFill",
	-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
	head = "TabLine",
	current_tab = "TabLineSel",
	not_current = "TabLine",
	tab = "TabLine",
	win = "TabLine",
	tail = "TabLine",
}

vim.api.nvim_create_autocmd("BufAdd", {
  pattern = "*",
  callback = function()
      -- print("vim leave")
      vim.cmd("silent! w")
	  vim.o.showtabline = 2
      -- vim.cmd("w")
  end,
})

require("tabby.tabline").set(function(line)
	return {
		-- {
		-- 	{ "%{%v:lua.require'nvim-navic'.get_location()%}" },
		-- 	-- { "22222222222" },
		-- },
		line.spacer(),
		line.bufs().foreach(function(buf)
			local current = buf.is_current()
			local hl = current and { style = "italic", fg = "#5b5b5b" } or { style = "italic", fg = "#3b3b3b" }
			return {
				line.sep(" ", hl, theme.fill),
				buf.name({
					-- mode = "shorten",
				}),
				hl = hl,
			}
		end),
		hl = theme.fill,
	}
end, {
	buf_name = {
		mode = "shorten", -- or 'relative', 'tail', 'shorten'
	},
})

-- require('mini.tabline').setup({
--     show_icons = false,
--     tabpage_section = 'left',
-- })
