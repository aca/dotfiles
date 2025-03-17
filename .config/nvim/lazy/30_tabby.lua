-- vim.o.showtabline = 0
vim.cmd.packadd("tabby.nvim")

function intToRoman(n)
	local romans = {
		"一",
		"二",
		"三",
		"四",
		"五",
		"六",
		"七",
		"八",
		"九",
		"十",
	}
	return romans[n]
end

local theme = {
	current = { fg = "#cad3f5", bg = "transparent", style = "bold" },
	not_current = { fg = "#5b6078", bg = "transparent" },

	fill = { bg = "transparent" },
}

-- local icon = active and '' or ''
require("tabby.tabline").set(function(line)
	return {
		{
			-- { "  " },
		},
		line.tabs().foreach(function(tab)
			local tabs = vim.api.nvim_list_tabpages()
			local count = #tabs
			if count == 1 then
				return {}
			end
			local hl = tab.is_current() and theme.current or theme.not_current
			return {
				line.sep(" ", hl, theme.fill),
				-- intToRoman(tab.number()),
				tab.number(),
				-- tab.name(),
				line.sep(" ", hl, theme.fill),
				hl = hl,
			}
		end),
		line.spacer(),
		line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
			local hl = win.is_current() and theme.current or theme.not_current
			return {
				line.sep(" ", hl, theme.fill),
				win.buf_name(),
				line.sep(" ", hl, theme.fill),
				hl = hl,
			}
		end),
		hl = theme.fill,
	}
end)
