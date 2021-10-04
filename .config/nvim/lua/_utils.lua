-- TODO!!: move to scripts

local M = {}
local vim = vim

function M.yankpath()
	local fp = vim.call("expand", "%:p")
	fp = fp:gsub(vim.call("expand", "~"), "~")

	local curpos = vim.fn.getcurpos()
	if fp == "" then
		return
	end

	print(fp .. ":" .. curpos[2])
	vim.cmd("let @+=" .. "'" .. fp .. ":" .. curpos[2] .. "'")
	vim.cmd("let @*=" .. "'" .. fp .. ":" .. curpos[2] .. "'")
end

function M.open_nextfile()
	local cwd = vim.fn.expand("%:p:h")
	local lst = vim.fn.systemlist("cd " .. cwd .. ' && find . -maxdepth 1 -not -type d | sort | sed -e "s/^.\\///" ')
	local index = {}
	for k, v in pairs(lst) do
		index[v] = k
	end

	local cur_idx = index[vim.fn.expand("%:t")]
	if cur_idx == nil then
		-- file not saved
		vim.api.nvim_exec("e " .. cwd .. "/" .. lst[#lst], true)
		return
	end
	if lst[cur_idx + 1] == nil then
		print("open_nextfile: reached end")
		return
	end
	vim.api.nvim_exec("e " .. cwd .. "/" .. lst[cur_idx + 1], true)
end

function M.open_prevfile()
	local cwd = vim.fn.expand("%:p:h")
	local lst = vim.fn.systemlist("cd " .. cwd .. ' && find . -maxdepth 1 -not -type d | sort | sed -e "s/^.\\///" ')
	local index = {}
	for k, v in pairs(lst) do
		index[v] = k
	end

	local cur_idx = index[vim.fn.expand("%:t")]
	if cur_idx == nil then
		-- file not saved
		vim.api.nvim_exec("e " .. cwd .. "/" .. lst[#lst], true)
		return
	end
	if lst[cur_idx - 1] == nil then
		print("open_prevfile: reached end")
		return
	end
	vim.api.nvim_exec("e " .. cwd .. "/" .. lst[cur_idx - 1], true)
end

return M
