local wezterm = require("wezterm")
local config = {
    unix_domains = {
        {
            name = "unix"
        }
    },
    default_gui_startup_args = {"connect", "unix"},
    leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 },
    send_composed_key_when_left_alt_is_pressed = false,
    keys = {
        { key = "w", mods = "CTRL", action = "QuickSelect" },

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

        -- close
        { key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
        { key = "x", mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },
        -- { key = "X", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },
       }
}

return config
