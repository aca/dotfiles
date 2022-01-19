local wezterm = require("wezterm")
local os = require("os")
local homedir = os.getenv("HOME")

-- wezterm.on("window-config-reloaded", function(window, pane)
--   window:toast_notification("wezterm", "configuration reloaded!", nil, 4000)
-- end)

local function log(msg)
	wezterm.log_info(msg)
end

-- wezterm.on("update-right-status", function(window, pane)
--   local status = ""
--   if window:dead_key_is_active() then
--     status = "COMPOSE"
--   end
--   window:set_right_status(status)
-- end);

wezterm.on("open_in_vim", function(window, pane)
	local file = io.open("/tmp/wezterm_buf", "w")
	file:write(pane:get_logical_lines_as_text(1000))
	file:close()
	window:perform_action(
		wezterm.action({
			SplitVertical = {
				domain = "CurrentPaneDomain",
				args = { "nvim.minimal", "/tmp/wezterm_buf", "-c", "call cursor(line('$')-1,0)" },
			},
		}),
		pane
	)
end)

local move_around = function(window, pane, direction_wez, direction_nvim)
	local result = os.execute(
		"env NVIM_LISTEN_ADDRESS=/tmp/nvim"
			.. pane:pane_id()
			.. " "
			.. homedir
			.. "/bin/"
			.. "wezterm.nvim.navigator "
			.. direction_nvim
	)
	if result then
		-- window:toast_notification("wezterm", "move in vim", nil, 4000)
		window:perform_action(wezterm.action({ SendString = "\x17" .. direction_nvim }), pane)
	else
		-- window:toast_notification("wezterm", "move in wezterm", nil, 4000)
		window:perform_action(wezterm.action({ ActivatePaneDirection = direction_wez }), pane)
	end
end

wezterm.on("move-left", function(window, pane)
	-- window:perform_action(wezterm.action({ ActivatePaneDirection = "Left" }), pane)
	move_around(window, pane, "Left", "h")
end)

wezterm.on("move-right", function(window, pane)
	move_around(window, pane, "Right", "l")
end)

wezterm.on("move-up", function(window, pane)
	move_around(window, pane, "Up", "k")
end)

wezterm.on("move-down", function(window, pane)
	move_around(window, pane, "Down", "j")
end)

local function file_exists(name)
	if os.execute("stat " .. name) then
		return true
	else
		return false
	end
end

local vim_resize = function(window, pane, direction_wez, direction_nvim)
	if file_exists("/tmp/nvim" .. pane:pane_id()) then
		window:perform_action(wezterm.action({ SendString = "\x1b" .. direction_nvim }), pane)
	else
		window:perform_action(wezterm.action({ AdjustPaneSize = { direction_wez, 5 } }), pane)
	end
end

wezterm.on("resize-left", function(window, pane)
	vim_resize(window, pane, "Left", "h")
end)

wezterm.on("resize-right", function(window, pane)
	vim_resize(window, pane, "Right", "l")
end)

wezterm.on("resize-up", function(window, pane)
	vim_resize(window, pane, "Up", "k")
end)

wezterm.on("resize-down", function(window, pane)
	vim_resize(window, pane, "Down", "j")
end)

local config = {
	window_decorations = "RESIZE",
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	tab_max_width = 100,

	font = wezterm.font("SauceCodePro Nerd Font Mono"),

	adjust_window_size_when_changing_font_size = false,
	default_prog = { "/usr/local/bin/fish", "--login" },
	enable_kitty_graphics = true,
	debug_key_events = true,
	set_environment_variables = {
		-- This fails to find wezterm.nvim.navigator
		PATH = os.getenv("PATH") .. ":/usr/local/bin" .. ":" .. homedir .. "/.bin" .. ":" .. homedir .. "/bin",
	},

	color_scheme = 'Blazer',
	use_ime = true,

  -- TODO
  quick_select_patterns = {
    "[%a]+",
  },

	-- no inactive pane
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 1.0,
	},

	-- timeout_milliseconds defaults to 1000 and can be omitted
	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 },
	send_composed_key_when_left_alt_is_pressed = false,
	keys = {

		{ key = "b", mods = "LEADER", action = wezterm.action({ EmitEvent = "open_in_vim" }) },
		{ key = "[", mods = "LEADER", action = wezterm.action({ EmitEvent = "open_in_vim" }) },

		{ key = "C", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }) },
		-- { key = "C", mods = "CTRL", action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }) },

		{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
		{ key = "=", mods = "CTRL", action = "IncreaseFontSize" },

		-- split
		{
			key = "%",
			mods = "LEADER|SHIFT",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "%",
			mods = "LEADER",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = '"',
			mods = "LEADER",
			action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = '"',
			mods = "LEADER|SHIFT",
			action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "v",
			mods = "LEADER",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{ key = "s", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },

		-- close
		{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
		-- { key = "X", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },
		{ key = "x", mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },

		{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
		{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
		{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
		{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
		{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
		{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
		{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
		{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
		{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },

		{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },

		{ key = "Backspace", mods = "LEADER", action = "ActivateLastTab" },
		{ key = ";", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = -1 }) },
		{ key = "'", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = 1 }) },

		-- pane move
		{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },

		-- { key = "h", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		-- { key = "j", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		-- { key = "k", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		-- { key = "l", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Right" }) },

		-- pane move(vim aware)
		{ key = "h", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-left" }) },
		{ key = "l", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-right" }) },
		{ key = "k", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-up" }) },
		{ key = "j", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-down" }) },

		-- resize
		{ key = "h", mods = "ALT", action = wezterm.action({ EmitEvent = "resize-left" }) },
		{ key = "l", mods = "ALT", action = wezterm.action({ EmitEvent = "resize-right" }) },
		{ key = "k", mods = "ALT", action = wezterm.action({ EmitEvent = "resize-up" }) },
		{ key = "j", mods = "ALT", action = wezterm.action({ EmitEvent = "resize-down" }) },
		-- { key = "h", mods = "ALT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
		-- { key = "j", mods = "ALT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
		-- { key = "k", mods = "ALT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
		-- { key = "l", mods = "ALT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },

		-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
		-- { key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },

		-- alt key
		{ key = "a", mods = "ALT", action = wezterm.action({ SendString = "\x1ba" }) },
		{ key = "b", mods = "ALT", action = wezterm.action({ SendString = "\x1bb" }) },
		{ key = "c", mods = "ALT", action = wezterm.action({ SendString = "\x1bc" }) },
		{ key = "d", mods = "ALT", action = wezterm.action({ SendString = "\x1bd" }) },
		{ key = "e", mods = "ALT", action = wezterm.action({ SendString = "\x1be" }) },
		{ key = "f", mods = "ALT", action = wezterm.action({ SendString = "\x1bf" }) },
		{ key = "g", mods = "ALT", action = wezterm.action({ SendString = "\x1bg" }) },
		-- { key = "h", mods = "ALT", action = wezterm.action({ SendString = "\x1bh" }) },
		{ key = "i", mods = "ALT", action = wezterm.action({ SendString = "\x1bi" }) },
		-- { key = "j", mods = "ALT", action = wezterm.action({ SendString = "\x1bj" }) },
		-- { key = "k", mods = "ALT", action = wezterm.action({ SendString = "\x1bk" }) },
		-- { key = "l", mods = "ALT", action = wezterm.action({ SendString = "\x1bl" }) },
		{ key = "m", mods = "ALT", action = wezterm.action({ SendString = "\x1bm" }) },
		{ key = "n", mods = "ALT", action = wezterm.action({ SendString = "\x1bn" }) },
		{ key = "o", mods = "ALT", action = wezterm.action({ SendString = "\x1bo" }) },
		{ key = "p", mods = "ALT", action = wezterm.action({ SendString = "\x1bp" }) },
		{ key = "q", mods = "ALT", action = wezterm.action({ SendString = "\x1bq" }) },
		{ key = "r", mods = "ALT", action = wezterm.action({ SendString = "\x1br" }) },
		{ key = "s", mods = "ALT", action = wezterm.action({ SendString = "\x1bs" }) },
		{ key = "t", mods = "ALT", action = wezterm.action({ SendString = "\x1bt" }) },
		{ key = "u", mods = "ALT", action = wezterm.action({ SendString = "\x1bu" }) },
		{ key = "v", mods = "ALT", action = wezterm.action({ SendString = "\x1bv" }) },
		{ key = "w", mods = "ALT", action = wezterm.action({ SendString = "\x1bw" }) },
		{ key = "x", mods = "ALT", action = wezterm.action({ SendString = "\x1bx" }) },
		{ key = "y", mods = "ALT", action = wezterm.action({ SendString = "\x1by" }) },
		{ key = "z", mods = "ALT", action = wezterm.action({ SendString = "\x1bz" }) },


		-- {
		-- 	key = "a",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bA" }),
		-- },
		-- {
		-- 	key = "b",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bB" }),
		-- },
		-- {
		-- 	key = "c",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bC" }),
		-- },
		-- {
		-- 	key = "d",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bD" }),
		-- },
		-- {
		-- 	key = "e",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bE" }),
		-- },
		-- {
		-- 	key = "f",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bF" }),
		-- },
		-- {
		-- 	key = "g",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bG" }),
		-- },
		-- {
		-- 	key = "h",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bH" }),
		-- },
		-- {
		-- 	key = "i",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bI" }),
		-- },
		-- {
		-- 	key = "j",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bJ" }),
		-- },
		-- {
		-- 	key = "k",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bK" }),
		-- },
		-- {
		-- 	key = "l",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bL" }),
		-- },
		-- {
		-- 	key = "m",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bM" }),
		-- },
		-- {
		-- 	key = "n",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bN" }),
		-- },
		-- {
		-- 	key = "o",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bO" }),
		-- },
		-- {
		-- 	key = "p",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bP" }),
		-- },
		-- {
		-- 	key = "q",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bQ" }),
		-- },
		-- {
		-- 	key = "r",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bR" }),
		-- },
		-- {
		-- 	key = "s",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bS" }),
		-- },
		-- {
		-- 	key = "t",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bT" }),
		-- },
		-- {
		-- 	key = "u",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bU" }),
		-- },
		-- {
		-- 	key = "v",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bV" }),
		-- },
		-- {
		-- 	key = "w",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bW" }),
		-- },
		-- {
		-- 	key = "x",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bX" }),
		-- },
		-- {
		-- 	key = "y",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bY" }),
		-- },
		-- {
		-- 	key = "z",
		-- 	mods = "ALT|SHIFT",
		-- 	action = wezterm.action({ SendString = "\x1bZ" }),
		-- },
    --
    --
    {key=";", mods="CTRL", action=wezterm.action{ScrollByLine=-3}},
    {key="'", mods="CTRL", action=wezterm.action{ScrollByLine=3}},
	},
}

if wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	table.insert(
		config.keys,
		{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "PrimarySelection" }) }
	)
else
	-- table.insert(config.keys, { key = "V", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) })
end

return config
