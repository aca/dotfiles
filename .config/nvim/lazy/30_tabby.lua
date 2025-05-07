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
	fill = "TabLineFill",
	-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
	head = "TabLine",
	current_tab = "TabLineSel",
	not_current = "TabLine",
	tab = "TabLine",
	win = "TabLine",
	tail = "TabLine",
}

require("tabby.tabline").set(function(line)
	return {
		{
            -- {"-"},
			{ "%{%v:lua.require'nvim-navic'.get_location()%}" },
		},
		line.spacer(),
		line.bufs().foreach(function(buf)
			local current = buf.is_current()
			local hl = current and { style = "bold", fg = "#5b5b5b" } or { style = "italic", fg = "#3b3b3b" }
			return {
				line.sep(" ", hl, theme.fill),
				buf.name({
                    mode = "shorten",
                }),
				hl = hl,
			}
		end),
		hl = theme.fill,
	}
end, {
    buf_name = {
      mode = 'shorten', -- or 'relative', 'tail', 'shorten'
    },
})
