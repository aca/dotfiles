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

-- local theme = {
-- 	-- current = { fg = "#cad3f5", bg = "transparent", style = "bold" },
-- 	-- not_current = { fg = "#5b6078", bg = "transparent" },
--
-- 	-- fill = { bg = "transparent" },
-- }

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

-- local icon = active and '' or ''
require("tabby.tabline").set(function(line)
	return {
		{
			-- { "  " },
		},
		-- line.tabs().foreach(function(tab)
		-- 	local tabs = vim.api.nvim_list_tabpages()
		-- 	local count = #tabs
		-- 	if count == 1 then
		-- 		return {}
		-- 	end
		-- 	local hl = tab.is_current() and theme.current or theme.not_current
		-- 	return {
		-- 		line.sep(" ", hl, theme.fill),
		-- 		-- intToRoman(tab.number()),
		-- 		tab.number(),
		-- 		-- tab.name(),
		-- 		line.sep(" ", hl, theme.fill),
		-- 		hl = hl,
		-- 	}
		-- end),

		-- line.tabs().foreach(function(tab)
		-- 	local hl = tab.is_current() and theme.current_tab or theme.tab
		-- 	return {
		-- 		-- tab.is_current() and "" or "󰆣",
		-- 		tab.number(),
		-- 		tab.name(),
		-- 		tab.close_btn(""),
		-- 		hl = hl,
		-- 		margin = " ",
		-- 	}
		-- end),
		line.spacer(),
		line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
			local hl = win.is_current() and theme.current or theme.not_current
			return {
				line.sep("", theme.win, theme.fill),
				win.is_current() and "" or "",
				win.buf_name(),
				line.sep("", theme.win, theme.fill),
				hl = theme.win,
				margin = " ",
			}
			-- return {
			-- 	line.sep("", hl, theme.fill),
			--              -- { win.buf_name(), "hl" = hl },
			--              { "werwer", hl},
			-- 	line.sep("", hl, theme.fill),
			-- 	-- line.sep(" ", hl, theme.fill),
			-- 	-- hl = hl,
			-- }
		end),
		hl = theme.fill,
	}
end)
