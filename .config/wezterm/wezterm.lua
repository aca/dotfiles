-- local wezterm = require("wezterm")
--
-- local config = {
--     font = wezterm.font("SauceCodePro Nerd Font"),
--     check_for_updates = false,
--     use_ime = true,
--     color_scheme = "Builtin Solarized Dark",
--     inactive_pane_hsb = {
--         hue = 1.0,
--         saturation = 1.0,
--         brightness = 1.0,
--     },
--     default_prog = { '/bin/bash', '-l' },
--     font_size = 16.0,
--     launch_menu = {},
--     leader = { key="b", mods="CTRL", timeout_milliseconds=10000 },
--     keys = {
--         { key = "x", mods = "LEADER",  action="ActivateCopyMode"},
--         { key = "%", mods = "LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
--         { key="|", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
--         { key="k", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
--         { key="-", mods="LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
--
--         { key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
--         { key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
--         { key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
--         { key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
--     },
--     set_environment_variables = {},
-- }
--
-- if wezterm.target_triple == "x86_64-pc-windows-msvc" then
--     config.front_end = "Software" -- OpenGL doesn't work quite well with RDP.
--     config.term = "" -- Set to empty so FZF works on windows
--     config.default_prog = { "cmd.exe" }
--     table.insert(config.launch_menu, { label = "PowerShell", args = {"powershell.exe", "-NoLogo"} })
--
--     -- Find installed visual studio version(s) and add their compilation
--     -- environment command prompts to the menu
--     for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files (x86)")) do
--         local year = vsvers:gsub("Microsoft Visual Studio/", "")
--         table.insert(config.launch_menu, {
--             label = "x64 Native Tools VS " .. year,
--             args = {"cmd.exe", "/k", "C:/Program Files (x86)/" .. vsvers .. "/BuildTools/VC/Auxiliary/Build/vcvars64.bat"},
--         })
--     end
-- else
--     table.insert(config.launch_menu, { label = "bash", args = {"bash", "-l"} })
--     table.insert(config.launch_menu, { label = "fish", args = {"fish", "-l"} })
-- end
--
-- return config

local wezterm = require("wezterm")

local move_around = function(window, pane, direction_wez, direction_nvim)
	wezterm.log_info(pane:get_title())
	wezterm.log_info(pane:get_title():sub(-4))
	wezterm.log_info(string.find(pane:get_title(), "vim"))
	if string.find(pane:get_title(), "vim") then
		-- wezterm.log_info("this is neovim")
		window:perform_action(wezterm.action({ SendString = "\x17" .. direction_nvim }), pane)
	else
		-- wezterm.log_info("this is not neovim")
		window:perform_action(wezterm.action({ ActivatePaneDirection = direction_wez }), pane)
	end
end

wezterm.on("move-left", function(window, pane)
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

return {

  adjust_window_size_when_changing_font_size = false,

  color_scheme = "Tomorrow Night Burns",

	-- timeout_milliseconds defaults to 1000 and can be omitted
	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {

    { key = "[", mods = "LEADER",  action="ActivateCopyMode"},

    {key="C", mods="CTRL|SHIFT", action=wezterm.action{CopyTo="ClipboardAndPrimarySelection"}},

    {key="-", mods="CTRL", action="DecreaseFontSize"},
    {key="=", mods="CTRL", action="IncreaseFontSize"},

    {key="v", mods="SHIFT|CTRL", action="Paste"},

    -- split
		{ key = "|", mods = "LEADER|SHIFT", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }), },
		{ key = '"', mods = "LEADER|SHIFT", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }), },
		{ key = "v", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }), },
		{ key = "s", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },

    -- close
		{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
		{ key = "X", mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },

		{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
		{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
		{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
		{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
		{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
		{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
		{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
		{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
		{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },

		{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab="CurrentPaneDomain" }) },

		{ key = ";", mods = "LEADER", action = wezterm.action({ ActivateTabRelative=-1 }) },
		{ key = "'", mods = "LEADER", action = wezterm.action({ ActivateTabRelative=1 }) },

    -- pane move
		{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },

    -- pane move(vim aware)
		{ key = "h", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-left" }) },
		{ key = "l", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-right" }) },
		{ key = "k", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-up" }) },
		{ key = "j", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-down" }) },


    -- resize
		{ key = "h", mods = "ALT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
		{ key = "j", mods = "ALT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
		{ key = "k", mods = "ALT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
		{ key = "l", mods = "ALT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },

		-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
		{ key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },
	},
}

-- return {
-- 	-- timeout_milliseconds defaults to 1000 and can be omitted
-- 	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 3000 },
-- 	use_ime = true,
-- 	keys = {
-- 		{
-- 			key = "v",
-- 			mods = "LEADER",
-- 			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
-- 		},
-- 		{
-- 			key = "s",
-- 			mods = "LEADER",
-- 			action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
-- 		},
-- 	},
-- }

-- return {
-- 	-- timeout_milliseconds defaults to 1000 and can be omitted
-- 	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 3000 },
-- 	use_ime = true,
-- 	keys = {
-- 		{ key = "v", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
-- 		-- { key = "%", mods = "LEADER|SHIFT", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
-- 		-- { key = '"', mods = "LEADER|SHIFT", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
-- 		{ key = "s", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
--
-- 		{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
-- 		{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
-- 		{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
-- 		{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
--
-- 		{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
-- 		{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
-- 		{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
-- 		{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
--
--
-- 		-- { key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
-- 		{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
-- 		{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
-- 		{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
-- 		{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
-- 		{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
--
--
-- 	},
-- }
