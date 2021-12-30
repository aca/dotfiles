vim.api.nvim_add_user_command("NextFile", function(opts)
	local cwd = vim.fn.fnameescape(vim.fn.expand("%:p:h"))
	local lst = vim.fn.systemlist("find " .. cwd .. ' -maxdepth 1 -not -type d | sort | sed -e "s/^.\\///" ')
	local index = {}
	for k, v in pairs(lst) do
		index[v] = k
	end

	P(lst)

	-- local cur_idx = index[vim.fn.expand("%:t")]
	-- if cur_idx == nil then
	-- 	-- file not saved
	-- 	vim.api.nvim_exec("e " .. cwd .. "/" .. lst[#lst], true)
	-- 	return
	-- en
	-- if lst[cur_idx + 1] == nil then
	-- 	print("open_nextfile: reached end")
	-- 	return
	-- end
	--  print(vim.fn.fnameescape(lst[cur_idx + 1]))
	--  vim.api.nvim_exec("e " .. vim.fn.fnameescape(lst[cur_idx + 1]), true)
end, {})

vim.api.nvim_add_user_command("PrevFile", function(opts)
	local cwd = vim.fn.fnameescape(vim.fn.expand("%:p:h"))
	local lst = vim.fn.systemlist("find " .. cwd .. ' -maxdepth 1 -not -type d | sort | sed -e "s/^.\\///" ')
	P(lst)
	local index = {}
	for k, v in pairs(lst) do
		index[v] = k
	end

	-- local cur_idx = index[vim.fn.expand("%:t")]
	-- if cur_idx == nil then
	-- 	-- file not saved
	-- 	vim.api.nvim_exec("e " .. cwd .. "/" .. lst[#lst], true)
	-- 	return
	-- end
	-- if lst[cur_idx - 1] == nil then
	-- 	print("open_prevfile: reached end")
	-- 	return
	-- end
	--  print(vim.fn.fnameescape(lst[cur_idx - 1]))
	-- vim.api.nvim_exec("e " .. vim.fn.fnameescape(lst[cur_idx - 1]), true)
end, {})
