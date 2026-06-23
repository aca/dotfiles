-- https://www.reddit.com/r/neovim/comments/1j75ddf/minimalist_antidistractionzen_mode_plugin_in_lua/
--
local function init()
	--create pad hl
	local dfm_pad = vim.api.nvim_create_namespace('dfm_pad')
	for _, v in ipairs({'NonText', 'SignColumn', 'WinSeparator', 'StatusLine', 'StatusLineNC'}) do
		vim.api.nvim_set_hl(dfm_pad, v, {fg='bg', bg='bg', force=true})
	end
	vim.g.dfm_pad_style = dfm_pad
end

local function restore_window()
	vim.wo.wrap = vim.g.dfm_wrap
	vim.wo.linebreak = vim.g.dfm_linebreak
	vim.keymap.del('n', 'j')
	vim.keymap.del('n', 'k')
	vim.api.nvim_win_set_hl_ns(0, 0)
end

local function setup_window()
	vim.g.dfm_wrap = vim.wo.wrap
	vim.g.dfm_linebreak = vim.wo.wrap
	vim.wo.wrap = true
	vim.wo.linebreak = true
	vim.keymap.set('n', 'j', 'gj')
	vim.keymap.set('n', 'k', 'gk')
	vim.api.nvim_win_set_hl_ns(0, vim.g.dfm_pad_style)
end

local function open_splits(width, height)
	local win_w = vim.fn.winwidth(0)
	local win_h = vim.fn.winheight(0)
	local h_margin = math.floor(((win_w - width) / 2 - 1)+0.5)
	local v_margin = math.floor((win_h * (1 - height)  / 2 - 1)+0.5)
	local buf = vim.api.nvim_create_buf(false, true)
	local margins = {}
	local h_margins = {
		{ width=h_margin, vertical=true, split='left' },
		{ width=h_margin, vertical=true, split='right' },
	}
	local v_margins = {
		{ height=v_margin, split='above' },
		{ height=v_margin, split='below' },
	}
	if h_margin > 0 then vim.list_extend(margins, h_margins) end
	if v_margin > 0 then vim.list_extend(margins, v_margins) end
	local ids = {}
	for _, m in ipairs(margins) do
		m.win = 0
		m.style = 'minimal'
		m.focusable = false
		local win = vim.api.nvim_open_win(buf, false, m)
		vim.api.nvim_win_set_hl_ns(win, vim.g.dfm_pad_style)
		table.insert(ids, win)
	end
	return ids
end

local function close_splits(ids)
	local wins = vim.api.nvim_list_wins()
	local existing_ids = {}
	for _, id in ipairs(ids) do
		if vim.list_contains(wins, id) then
			table.insert(existing_ids, id)
		end
	end
	for _, id in ipairs(existing_ids) do
		vim.api.nvim_win_close(id, false)
	end
end

local function toggle_distraction_free_mode(width, height)
	if vim.w.dfm_win_ids then
		close_splits(vim.w.dfm_win_ids)
		vim.w.dfm_win_ids = nil
		restore_window()
	else
		vim.w.dfm_win_ids = open_splits(width, height)
		setup_window()
	end
end

init()
vim.api.nvim_create_user_command(
	'ToggleDistractionFreeMode',
	function(args)
		local w = args.fargs[1] or 80
		local h = args.fargs[2] or 0.8
		toggle_distraction_free_mode(w, h)
	end,
	{nargs='*'}
)
