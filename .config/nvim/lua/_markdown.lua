local M = {}
local vim = vim
local api = vim.api

-- https://stackoverflow.com/questions/29072601/lua-string-gsub-with-a-hyphen
local function replace(str, what, with)
	what = string.gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
	with = string.gsub(with, "[%%]", "%%%%") -- escape replacement
	local v, _ = string.gsub(str, what, with)
	return v
end

M.makelink = function()
	local line = api.nvim_get_current_line()
	local url = string.match(line, "[http://][https://][%w|%p]*")

	-- http://www.pixelbeat.org/cmdline.html
	-- sed -n 's/.*<title>\(.*\)<\/title>.*/\1/ip;T;q'
	local cmd = 'curl -s --fail "' .. url .. '"' .. "|" .. "sed -n 's/.*<title>\\(.*\\)<\\/title>.*/\\1/ip;T;q'"
	local err = vim.api.nvim_get_vvar("shell_error")
	if 0 ~= err then
		print("failed to update link")
		return
	end

	local title = vim.fn.systemlist(cmd)[1]
	local replaced = string.format("[%s](%s)", title, url)
	api.nvim_set_current_line(replace(line, url, replaced))
end

return M
