local wezterm = require("wezterm")
local os = require("os")
local homedir = os.getenv("HOME")

-- wezterm.on("window-config-reloaded", function(window, pane)
--   window:toast_notification("wezterm", "configuration reloaded!", nil, 4000)
-- end)

local function log(msg)
    wezterm.log_info(msg)
end

-- local inTmux = true
-- if os.getenv("TMUX") ~= "" then
--   inTmux = false
-- end

-- wezterm.on("update-right-status", function(window, pane)
--   local status = ""
--   if window:dead_key_is_active() then
-- if window:dead_key_is_active() then
--     status = "COMPOSE"
--   end
--   window:set_right_status(status)
-- end);

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- wezterm.on("update-right-status", function(window, pane)
--     -- window:set_right_status(basename(pane:get_foreground_process_name()))
--     -- window:set_right_status(pane:get_foreground_process_name())
--     -- window:toast_notification("wezterm", pane:get_foreground_process_name(), nil, 4000)
--     -- window:toast_notification("wezterm", pane:get_current_working_dir(), nil, 4000)
--
--     local date = wezterm.strftime("%Y-%m-%d %H:%M")
--     local cmd = string.format(
--         "cd '%s' && git rev-parse --abbrev-ref HEAD",
--         string.sub(pane:get_current_working_dir(), 8)
--     )
--     local handle = io.popen(cmd)
--     local result = handle:read("*a")
--     handle:close()
--     result = string.gsub(result, "\n", "")
--     window:set_right_status(wezterm.format({
--         -- {Attribute={Underline="Single"}},
--         { Attribute = { Italic = true } },
--         { Text = result .. " | " .. date .. " " },
--     }))
-- end)

-- The filled in variant of the < symbol
-- local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
--
-- -- The filled in variant of the > symbol
-- local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

-- TODO
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local cwd = tab.active_pane.current_working_dir:sub(8, -1):gsub(homedir, "~")
    if tab.is_active then
        return {
            { Background = { Color = "black" } },
            { Text = " " .. cwd .. " " },
        }
    end
    return {
        { Background = { Color = "black" } },
        { Text = " " .. tab.tab_index + 1 .. " " .. cwd .. "  " },
    }
end)

wezterm.on("open_in_vim", function(window, pane)
    local file = io.open("/tmp/wezterm_buf", "w")
    file:write(pane:get_logical_lines_as_text(5000))
    file:flush()
    file:close()

    window:perform_action(
        wezterm.action({
            SpawnCommandInNewTab = {
                args = { "nvim.wez", "/tmp/wezterm_buf", "-c", "call cursor(line('$')-1,0)" },
            },
        }),
        pane
    )

    -- window:perform_action(
    -- 	wezterm.action({
    -- 		SplitVertical = {
    -- 			domain = "CurrentPaneDomain",
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

local function file_exists(name)
    if os.execute("stat " .. name) then
        return true
    else
        return false
    end
end

local vim_resize = function(window, pane, direction_wez, direction_nvim)
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
    -- unix_domains = {
    --     {
    --         name = "unix",
    --     },
    -- },
    -- default_gui_startup_args = { "connect", "unix" },
    window_decorations = "RESIZE",
    cell_width = 0.85,
    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    -- window_background_opacity = 1,
    -- tab_max_width = 100,

    enable_scroll_bar = false,
    -- TODO !!!: performance issue, use tmux instead for now
    -- scrollback_lines = 10000,

    -- font_rules = {
    --   intensity = "Half",
    --   font = wezterm.font("SauceCodePro Nerd Font", { weight = "Regular" }),
    -- },

    font_rules = {
        -- Define a rule that matches when italic text is shown
        {
            -- If specified, this rule matches when a cell's italic value exactly
            -- matches this.  If unspecified, the attribute value is irrelevant
            -- with respect to matching.
            -- italic = true,

            -- Match based on intensity: "Bold", "Normal" and "Half" are supported
            -- intensity = "Half",

            -- Match based on underline: "None", "Single", and "Double" are supported
            -- underline = "None",

            -- Match based on the blink attribute: "None", "Slow", "Rapid"
            -- blink = "None",

            -- Match based on reverse video
            -- reverse = false,

            -- Match based on strikethrough
            -- strikethrough = false,

            -- Match based on the invisible attribute
            -- invisible = false,

            -- When the above attributes match, apply this font styling
            font = wezterm.font("BlexMono Nerd Font", { weight = "Light" }),
            -- font = wezterm.font("Monoid Nerd Font",{ stretch = "SemiCondensed"}) ,
            -- font = wezterm.font("IBM Plex Mono", {weight="Regular", stretch="Condensed", style="Normal"}),
        },
    },
    line_height = 1,
    -- adjust_window_size_when_changing_font_size = false,
    default_prog = { homedir .. "/bin/elvish" },
    -- default_prog = { "/bin/sh" },
    -- default_prog = { "/usr/local/bin/elvish" },
    -- default_prog = { "/usr/local/bin/fish", "--login"},
    enable_kitty_graphics = true,
    -- debug_key_events = true,
    set_environment_variables = {
        -- This fails to find wezterm.nvim.navigator
        PATH = os.getenv("PATH") .. ":/usr/local/bin" .. ":" .. homedir .. "/.bin" .. ":" .. homedir .. "/bin",
        -- prompt = "$E]7;file://localhost/$P$E\\$E]1;$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m ",
    },
    -- color_scheme = 'judi',

    -- colors = {
    --     ansi = { "#2f2e2d", "#a36666", "#90a57d", "#d7af87", "#7fa5bd", "#c79ec4", "#8adbb4", "#d0d0d0" },
    --     -- background = "#1c1c1c",
    --     background = "#000000",
    --     brights = { "#4a4845", "#d78787", "#afbea2", "#e4c9af", "#a1bdce", "#d7beda", "#b1e7dd", "#efefef" },
    --     cursor_bg = "#e4c9af",
    --     cursor_border = "#e4c9af",
    --     cursor_fg = "#000000",
    --     foreground = "#d0d0d0",
    --     selection_bg = "#4d4d4d",
    --     selection_fg = "#ffffff",
    -- },
    colors = {
        tab_bar = {
            -- The color of the inactive tab bar edge/divider
            inactive_tab_edge = "#575757",
            background = "#000000",
            new_tab = {
                bg_color = "#000000",
                fg_color = "#808080",

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab`.
            },
        },
    },
    status_update_interval = 10000,
    -- colors = {
    --   foreground = "#ffffff",
    --   background = "#000000",
    --   cursor_bg = "#7f7f7f",
    --   cursor_border = "#7f7f7f",
    --   cursor_fg = "#7f7f7f",
    --   selection_bg = "#cb392e",
    --   selection_fg = "#ffffff",
    --   ansi = {"#2e2e2e","#fc6d26","#3eb383","#fca121","#db3b21","#380d75","#6e49cb","#ffffff"},
    --   brights = {"#464646","#ff6517","#53eaa8","#fca013","#db501f","#441090","#7d53e7","#ffffff"},
    -- },
    -- use_ime = true,
    use_ime = false,
    -- TODO
    quick_select_patterns = {
        "[A-Za-z0-9-_.]{6,100}",
    },
    -- no inactive pane
    inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.9,
    },
    window_padding = {
        left = "1cell",
        right = "0cell",
        top = "0cell",
        bottom = "0cell",
    },
    -- timeout_milliseconds defaults to 1000 and can be omitted
    -- leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
    leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 },
    send_composed_key_when_left_alt_is_pressed = false,
    keys = {
        { key = "w", mods = "CTRL",       action = "QuickSelect" },

        { key = "b", mods = "LEADER",     action = wezterm.action({ EmitEvent = "open_in_vim" }) },
        { key = "[", mods = "LEADER",     action = wezterm.action({ EmitEvent = "open_in_vim" }) },

        { key = "w", mods = "LEADER",     action = "QuickSelect" },

        { key = "Z", mods = "LEADER",     action = "TogglePaneZoomState" },
        { key = "z", mods = "LEADER",     action = "TogglePaneZoomState" },

        -- {key="UpArrow", mods="SHIFT", action=wezterm.action{ScrollToPrompt=-1}},
        -- {key="DownArrow", mods="SHIFT", action=wezterm.action{ScrollToPrompt=1}},

        { key = "C", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }) },
        -- { key = "C", mods = "CTRL", action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }) },

        { key = "-", mods = "CTRL",       action = "DecreaseFontSize" },
        { key = "=", mods = "CTRL",       action = "IncreaseFontSize" },

        -- {key="X", mods="CTRL", action="ActivateCopyMode"},

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

        { key = "s",         mods = "LEADER",       action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },

        -- close
        -- { key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
        { key = "x",         mods = "LEADER",       action = wezterm.action.CloseCurrentPane { confirm = false } },
        -- { key = "X", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },
        { key = "x",         mods = "LEADER|SHIFT", action = wezterm.action.CloseCurrentPane { confirm = false } },

        { key = "1",         mods = "LEADER",       action = wezterm.action({ ActivateTab = 0 }) },
        { key = "2",         mods = "LEADER",       action = wezterm.action({ ActivateTab = 1 }) },
        { key = "3",         mods = "LEADER",       action = wezterm.action({ ActivateTab = 2 }) },
        { key = "4",         mods = "LEADER",       action = wezterm.action({ ActivateTab = 3 }) },
        { key = "5",         mods = "LEADER",       action = wezterm.action({ ActivateTab = 4 }) },
        { key = "6",         mods = "LEADER",       action = wezterm.action({ ActivateTab = 5 }) },
        { key = "7",         mods = "LEADER",       action = wezterm.action({ ActivateTab = 6 }) },
        { key = "8",         mods = "LEADER",       action = wezterm.action({ ActivateTab = 7 }) },
        { key = "9",         mods = "LEADER",       action = wezterm.action({ ActivateTab = 8 }) },

        { key = "c",         mods = "LEADER",       action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },

        { key = "Backspace", mods = "LEADER",       action = "ActivateLastTab" },
        { key = ";",         mods = "LEADER",       action = wezterm.action({ ActivateTabRelative = -1 }) },
        { key = "'",         mods = "LEADER",       action = wezterm.action({ ActivateTabRelative = 1 }) },

        -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
        -- { key = "q", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x0r" }) },
        { key = "q",         mods = "CTRL",         action = wezterm.action({ SendString = "\x11" }) },

        { key = ";",         mods = "CTRL",         action = wezterm.action({ ScrollByLine = -3 }) },
        { key = "'",         mods = "CTRL",         action = wezterm.action({ ScrollByLine = 3 }) },

        { key = "a",         mods = "ALT",          action = wezterm.action({ SendString = "\x1ba" }) },
        { key = "b",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bb" }) },
        { key = "c",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bc" }) },
        { key = "d",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bd" }) },
        { key = "e",         mods = "ALT",          action = wezterm.action({ SendString = "\x1be" }) },
        { key = "f",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bf" }) },
        { key = "g",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bg" }) },
        { key = "i",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bi" }) },
        { key = "m",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bm" }) },
        { key = "n",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bn" }) },
        { key = "o",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bo" }) },
        { key = "p",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bp" }) },
        { key = "q",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bq" }) },
        { key = "r",         mods = "ALT",          action = wezterm.action({ SendString = "\x1br" }) },
        { key = "s",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bs" }) },
        { key = "t",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bt" }) },
        { key = "u",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bu" }) },
        { key = "v",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bv" }) },
        { key = "w",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bw" }) },
        { key = "x",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bx" }) },
        { key = "y",         mods = "ALT",          action = wezterm.action({ SendString = "\x1by" }) },
        { key = "z",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bz" }) },

        -- alt key
        { key = "h",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bh" }) },
        { key = "j",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bj" }) },
        { key = "k",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bk" }) },
        { key = "l",         mods = "ALT",          action = wezterm.action({ SendString = "\x1bl" }) },

        -- pane move
        { key = "h",         mods = "LEADER",       action = wezterm.action({ ActivatePaneDirection = "Left" }) },
        { key = "j",         mods = "LEADER",       action = wezterm.action({ ActivatePaneDirection = "Down" }) },
        { key = "k",         mods = "LEADER",       action = wezterm.action({ ActivatePaneDirection = "Up" }) },
        { key = "l",         mods = "LEADER",       action = wezterm.action({ ActivatePaneDirection = "Right" }) },

        -- -- pane move(vim aware)
        { key = "h",         mods = "CTRL",         action = wezterm.action({ EmitEvent = "move-left" }) },
        { key = "l",         mods = "CTRL",         action = wezterm.action({ EmitEvent = "move-right" }) },
        { key = "k",         mods = "CTRL",         action = wezterm.action({ EmitEvent = "move-up" }) },
        { key = "j",         mods = "CTRL",         action = wezterm.action({ EmitEvent = "move-down" }) },
        -- resize(vim aware)
        { key = "h",         mods = "ALT",          action = wezterm.action({ EmitEvent = "resize-left" }) },
        { key = "l",         mods = "ALT",          action = wezterm.action({ EmitEvent = "resize-right" }) },
        { key = "k",         mods = "ALT",          action = wezterm.action({ EmitEvent = "resize-up" }) },
        { key = "j",         mods = "ALT",          action = wezterm.action({ EmitEvent = "resize-down" }) },
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
