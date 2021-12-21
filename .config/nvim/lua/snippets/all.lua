local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

local function shebang(_, _)
	local cstring = vim.split(vim.bo.commentstring, "%s", true)[1]
	if cstring == "/*" then
		cstring = "//"
	end
	cstring = vim.trim(cstring)
	return sn(nil, {
		t(cstring),
		t("!/usr/bin/env "),
		i(1, vim.bo.filetype),
	})
end

return {
	s({ trig = "hd", dscr = "Add SheBang" }, {
		d(1, shebang, {}),
	}),
}
