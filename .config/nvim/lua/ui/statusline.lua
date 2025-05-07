local utils = require("ui.utils")
-- local get_opt = vim.api.nvim_get_option_value
--
local M = {}
--
-- -- see https://vimhelp.org/options.txt.html#%27statusline%27 for part fmt strs
-- local stl_parts = {
-- 	buf_info = nil,
-- 	diag = nil,
-- 	git_info = nil,
-- 	modifiable = nil,
-- 	modified = nil,
-- 	pad = " ",
-- 	path = nil,
-- 	ro = nil,
-- 	scrollbar = nil,
-- 	sep = "%=",
-- 	trunc = "%<",
-- 	venv = nil,
-- }
--
-- local stl_order = {
-- 	"pad",
-- 	"path",
-- 	"venv",
-- 	"mod",
-- 	"ro",
-- 	"sep",
-- 	"diag",
-- 	"fileinfo",
-- 	"pad",
-- 	"scrollbar",
-- 	"pad",
-- }
--
-- local icons = tools.ui.icons
--
-- local ui_icons = {
-- 	["branch"] = { "DiagnosticOk", icons["branch"] },
-- 	["file"] = { "NonText", icons["node"] },
-- 	["fileinfo"] = { "DiagnosticInfo", icons["hamburger"] },
-- 	["nomodifiable"] = { "DiagnosticWarn", icons["bullet"] },
-- 	["modified"] = { "DiagnosticError", icons["bullet"] },
-- 	["readonly"] = { "DiagnosticWarn", icons["lock"] },
-- 	["error"] = { "DiagnosticError", icons["error"] },
-- 	["warn"] = { "DiagnosticWarn", icons["warning"] },
-- }
--
-- --------------------------------------------------
-- -- Utilities
-- --------------------------------------------------
-- local function hl_icons(icon_list)
-- 	local hl_syms = {}
--
-- 	for name, list in pairs(icon_list) do
-- 		hl_syms[name] = tools.hl_str(list[1], list[2])
-- 	end
--
-- 	return hl_syms
-- end
--
-- -- Get fmt strs from dict and concatenate them into one string.
-- -- @param key_list: table of keys to use to access fmt strings
-- -- @param dict: associative array to get fmt strings from
-- -- @return string of concatenated fmt strings and data that will create the
-- -- statusline when evaluated
-- local function ordered_tbl_concat(order_tbl, stl_part_tbl)
-- 	local str_table = {}
-- 	local part = nil
--
-- 	for _, val in ipairs(order_tbl) do
-- 		part = stl_part_tbl[val]
-- 		if part then
-- 			table.insert(str_table, part)
-- 		end
-- 	end
--
-- 	return table.concat(str_table, " ")
-- end
--
-- --------------------------------------------------
-- -- String Generation
-- --------------------------------------------------
-- local hl_ui_icons = hl_icons(ui_icons)
--
-- local function escape_str(str)
-- 	local output = str:gsub("([%(%)%%%+%-%*%?%[%]%^%$])", "%%%1")
-- 	return output
-- end
--
-- -- PATH WIDGET
-- --- Create a string containing info for the current git branch
-- --- @return string: branch info
-- local function get_path_info(root, fname, icon_tbl)
-- 	local file_name = vim.fn.fnamemodify(fname, ":t")
--
-- 	local file_icon, icon_hl = require("mini.icons").get("file", file_name)
-- 	file_icon = file_name ~= "" and tools.hl_str(icon_hl, file_icon) or ""
-- 	file_icon = ""
--
-- 	local file_icon_name = table.concat({ file_icon, file_name })
--
-- 	if vim.bo.buftype == "help" then
-- 		return table.concat({ icon_tbl["file"], file_icon_name })
-- 	end
--
-- 	-- local remote = tools.get_git_remote_name(root)
-- 	local remote = ""
-- 	local branch = ""
--
-- 	-- local branch = tools.get_git_branch(root)
-- 	-- local dir_path = vim.fn.fnamemodify(fname, ":h") .. "/"
--
-- 	-- FIXME: how much we show should depend on how long
-- 	-- the total statusline string is, not just the len
-- 	-- of the directory itself
-- 	local win_width = vim.api.nvim_win_get_width(0)
-- 	local dir_threshold_width = 15
-- 	local repo_threshold_width = 10
--
-- 	local repo_info = ""
-- 	-- if remote and branch then
--
--     -- dir_path = "%f"
--
-- 	-- dir_path = string.gsub(dir_path, "^" .. escape_str(root) .. "/", "")
-- 	-- if false then
-- 	-- 	repo_info = table.concat({
-- 	-- 		-- icon_tbl["branch"],
-- 	-- 		-- ' ',
-- 	-- 		-- remote,
-- 	-- 		-- ':',
-- 	-- 		-- branch,
-- 	-- 		-- ' ',
-- 	-- 	})
-- 	-- end
--
-- 	-- dir_path = win_width >= dir_threshold_width + #repo_info + #dir_path + #file_icon_name and dir_path or ""
--
-- 	-- repo_info = win_width >= repo_threshold_width + #repo_info + #file_icon_name and repo_info or ""
--
-- 	return table.concat({
-- 		-- repo_info,
-- 		-- icon_tbl["file"],
-- 		-- dir_path,
-- 		file_icon_name,
-- 	})
-- end
--
-- local function get_vlinecount_str()
-- 	local raw_count = vim.fn.line(".") - vim.fn.line("v")
-- 	raw_count = raw_count < 0 and raw_count - 1 or raw_count + 1
--
-- 	return tools.group_number(math.abs(raw_count), ",")
-- end
--
-- --- Get wordcount for current buffer or visual selection
-- --- @return string word count
-- local function get_fileinfo_widget(icon_tbl)
-- 	local ft = get_opt("filetype", {})
-- 	local lines = tools.group_number(vim.api.nvim_buf_line_count(0), ",")
--
-- 	-- For source code: return icon and line count
-- 	if not tools.nonprog_modes[ft] then
-- 		return table.concat({ icon_tbl.fileinfo, " ", lines, " lines" })
-- 	end
--
-- 	local wc_table = vim.fn.wordcount()
-- 	if not wc_table.visual_words or not wc_table.visual_chars then
-- 		-- Normal mode word count and file info
-- 		return table.concat({
-- 			icon_tbl.fileinfo,
-- 			" ",
-- 			lines,
-- 			" lines  ",
-- 			tools.group_number(wc_table.words, ","),
-- 			" words ",
-- 		})
-- 	else
-- 		-- Visual selection mode: line count, word count, and char count
-- 		return table.concat({
-- 			tools.hl_str("DiagnosticInfo", "‹›"),
-- 			" ",
-- 			get_vlinecount_str(),
-- 			" lines  ",
-- 			tools.group_number(wc_table.visual_words, ","),
-- 			" words  ",
-- 			tools.group_number(wc_table.visual_chars, ","),
-- 			" chars",
-- 		})
-- 	end
-- end
--
-- --- Get the name of the current venv in Python
-- --- @return string name of venv or "No venv"
-- local get_py_venv = function()
-- 	local candidates = {
-- 		{
-- 			var = "VIRTUAL_ENV",
-- 			label = "'.venv':",
-- 			fmt = function(path)
-- 				return tools.hl_str("Comment", vim.fn.fnamemodify(path, ":t"))
-- 			end,
-- 		},
-- 		{
-- 			var = "CONDA_DEFAULT_ENV",
-- 			label = "conda:",
-- 			fmt = function(name)
-- 				return tools.hl_str("Comment", name)
-- 			end,
-- 		},
-- 	}
--
-- 	for _, c in ipairs(candidates) do
-- 		local raw = vim.env[c.var]
-- 		if raw and raw ~= "" then
-- 			return string.format("%s %s  ", c.label, c.fmt(raw))
-- 		end
-- 	end
--
-- 	return tools.hl_str("Comment", "[no venv]")
-- end
--
local function get_scrollbar()
	local sbar_chars = {
		"▔",
		"🮂",
		"🬂",
		"🮃",
		"▀",
		"▄",
		"▃",
		"🬭",
		"▂",
		"▁",
	}

	local cur_line = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_line_count(0)

	local i = math.floor((cur_line - 1) / lines * #sbar_chars) + 1
	local sbar = string.rep(sbar_chars[i], 2)

	return tools.hl_str("Substitute", sbar)
end
--
-- --- Creates statusline
-- --- @return string statusline text to be displayed
-- M.render = function()
-- 	local fname = vim.api.nvim_buf_get_name(0)
-- 	local root = nil
-- 	if vim.bo.buftype == "terminal" or vim.bo.buftype == "nofile" or vim.bo.buftype == "prompt" then
-- 		fname = vim.bo.ft
-- 		return "%{%v:lua.vim.fn.getcwd()%}"
-- 	else
-- 		root = tools.get_path_root(fname)
-- 	end
--
-- 	local buf_num = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
--
-- 	stl_parts["path"] = get_path_info(root, fname, hl_ui_icons)
-- 	stl_parts["ro"] = get_opt("readonly", { buf = buf_num }) and hl_ui_icons["readonly"] or ""
--
-- 	if not get_opt("modifiable", { buf = buf_num }) then
-- 		stl_parts["mod"] = hl_ui_icons["nomodifiable"]
-- 	elseif get_opt("modified", { buf = buf_num }) then
-- 		stl_parts["mod"] = hl_ui_icons["modified"]
-- 	else
-- 		stl_parts["mod"] = " "
-- 	end
--
-- 	-- middle
-- 	-- filetype-specific info
-- 	-- if vim.bo.filetype == "python" then
-- 	--   stl_parts["venv"] = get_py_venv()
-- 	-- end
--
-- 	-- right
-- 	-- stl_parts["diag"] = get_diag_str()
-- 	-- stl_parts["fileinfo"] = get_fileinfo_widget(hl_ui_icons)
-- 	stl_parts["scrollbar"] = get_scrollbar()
--
-- 	-- turn all of these pieces into one string
-- 	return ordered_tbl_concat(stl_order, stl_parts)
-- end
--
--
--
M.render = function()
	-- return "%<%f %h%m%r%=%-14.(%l,%c%V%)" .. get_scrollbar()
	local ok, result = pcall(get_scrollbar)
	local out = (ok and result) or ""
	return "%<%f %h%m%r%=" .. result
	-- return "%<%f %h%m%r%=%-14.(%l,%c%V%)" .. get_scrollbar()
end

vim.o.statusline = "%!v:lua.require('ui.statusline').render()"
-- vim.o.statusline = "%!v:lua.require('ui.statusline').render()"
-- -- vim.o.statusline = "------------- %!v:lua.require('ui.statusline').render()"

-- reset
-- https://github.com/aserowy/tmux.nvim/issues/105
vim.o.laststatus = vim.o.laststatus
vim.o.cmdheight = 0

return M

