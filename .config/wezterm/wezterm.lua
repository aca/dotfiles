local wezterm = require("wezterm")
local os = require("os")
local homedir = os.getenv("HOME")

wezterm.on("window-config-reloaded", function(window, pane)
  window:toast_notification("wezterm", "configuration reloaded!", nil, 4000)
end)

function log(msg)
  wezterm.log_info(msg);
end

wezterm.on("open_in_vim", function(window, pane)
	local file = io.open("/tmp/wezterm_buf", "w")
	file:write(pane:get_logical_lines_as_text(3000))
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
	-- window:perform_action(
	-- 	wezterm.action({
	-- 		SpawnCommandInNewTab = {
	-- 			args = { "nvim.minimal", "/tmp/wezterm_buf", "-c", "call cursor(line('$')-1,0)" },
	-- 		},
	-- 	}),
	-- 	pane
	-- )
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
		window:perform_action(wezterm.action({ SendString = "\x17" .. direction_nvim }), pane)
	else
		window:perform_action(wezterm.action({ ActivatePaneDirection = direction_wez }), pane)
	end
  -- window:perform_action(wezterm.action({ ActivatePaneDirection = direction_wez }), pane)
end

wezterm.on("move-left", function(window, pane)
	-- move_around(window, pane, "Left", "h")
  window:perform_action(wezterm.action({ ActivatePaneDirection = "Left" }), pane)
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

function file_exists(name)
	-- local f = io.open(name, "r")
	-- if f ~= nil then
	-- 	io.close(f)
	-- 	return true
	-- else
	-- 	return false
	-- end
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
	font = wezterm.font("BlexMono Nerd Font Mono"),
	adjust_window_size_when_changing_font_size = false,
	default_prog = { "/usr/local/bin/fish", "--login" },
	enable_kitty_graphics = true,
	-- debug_key_events = true,
	set_environment_variables = {
		-- This fails to find wezterm.nvim.navigator
		PATH = os.getenv("PATH") .. ":/usr/local/bin" .. ":" .. homedir .. "/.bin" .. ":" .. homedir .. "/bin",
	},

	color_scheme = "Arthur",
	use_ime = false,

	-- timeout_milliseconds defaults to 1000 and can be omitted
	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {

		-- { key = "b", mods = "LEADER", action = wezterm.action({ EmitEvent = "open_in_vim" }) },
		{ key = "[", mods = "LEADER", action = wezterm.action({ EmitEvent = "open_in_vim" }) },

		{ key = "C", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }) },
		{ key = "C", mods = "CTRL", action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }) },

		{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
		{ key = "=", mods = "CTRL", action = "IncreaseFontSize" },

		{ key = "v", mods = "SHIFT|CTRL", action = "Paste" },

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
		{ key = "X", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },
		{ key = "X", mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },

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
		{ key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },
	},
}

return config
