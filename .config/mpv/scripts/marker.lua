-- Video range marker
-- m: mark start; m again: mark end and prompt for label.
-- Typing a label + enter appends the range to ~/store/video/<label>.edl
-- Empty input or Esc cancels.

local utils = require 'mp.utils'

local start_time = nil

local overlay = mp.create_osd_overlay("ass-events")
local hide_timer = nil
local input_active = false

local function show(text)
    overlay.data = "{\\an8}" .. tostring(text):gsub("\n", "\\N")
    overlay:update()
end

local function hide() overlay:remove() end

local function osd(text, duration)
    duration = duration or 3
    show(text)
    if hide_timer then hide_timer:kill() end
    hide_timer = mp.add_timeout(duration, hide)
end

local function edl_dir()
    return utils.join_path(os.getenv("HOME"), "store/video")
end

local function append_range(label, path, s, e)
    local length = e - s
    if length <= 0 then return false, "non-positive length" end

    local ok = os.execute("mkdir -p " .. string.format("%q", edl_dir()))
    if not ok then return false, "mkdir failed" end

    local file = utils.join_path(edl_dir(), label .. ".edl")
    local f = io.open(file, "r")
    local need_header = (f == nil)
    if f then f:close() end

    local err
    f, err = io.open(file, "a")
    if not f then return false, err end
    if need_header then
        f:write("# mpv EDL v0\n")
    end
    f:write(string.format("%s,%.3f,%.3f\n", path, s, length))
    f:close()
    return true, file
end

-- ASS-escape a string for safe rendering in overlay.
local function ass_escape(s)
    return s:gsub("\\", "\\\\"):gsub("{", "\\{"):gsub("}", "\\}")
end

-- Custom top-aligned text prompt using forced key bindings.
-- Keys: printable ASCII 32..126, BS/ENTER/ESC.
local prompt_keys = {}
do
    for i = 33, 126 do prompt_keys[#prompt_keys + 1] = string.char(i) end
    prompt_keys[#prompt_keys + 1] = "SPACE"
    prompt_keys[#prompt_keys + 1] = "BS"
    prompt_keys[#prompt_keys + 1] = "ENTER"
    prompt_keys[#prompt_keys + 1] = "ESC"
end

local function prompt_input(title, on_submit)
    if input_active then return end
    input_active = true
    local buf = ""

    local function render()
        show(ass_escape(title) .. ass_escape(buf) .. "_")
    end

    local function finish(result)
        if not input_active then return end
        input_active = false
        for _, k in ipairs(prompt_keys) do
            mp.remove_key_binding("marker-input-" .. k)
        end
        hide()
        on_submit(result)
    end

    local function key(k)
        return function()
            if k == "ESC" then
                finish(nil)
            elseif k == "ENTER" then
                finish(buf)
            elseif k == "BS" then
                buf = buf:sub(1, -2)
                render()
            elseif k == "SPACE" then
                buf = buf .. " "
                render()
            else
                buf = buf .. k
                render()
            end
        end
    end

    for _, k in ipairs(prompt_keys) do
        mp.add_forced_key_binding(k, "marker-input-" .. k, key(k), "repeatable")
    end

    if hide_timer then hide_timer:kill() end
    render()
end

local function prompt(s, e)
    local path = mp.get_property("path")
    if not path then
        osd("marker: no file")
        return
    end
    if not path:match("^%a[%w+%-.]*://") then
        path = utils.join_path(mp.get_property("working-directory"), path)
    end

    prompt_input("label: ", function(text)
        text = text and text:gsub("^%s+", ""):gsub("%s+$", "") or ""
        if text == "" then
            osd("marker: cancelled")
            return
        end
        local ok, info = append_range(text, path, s, e)
        if ok then
            osd(string.format("marker: +%s (%.2fs) -> %s", text, e - s, info))
        else
            osd("marker: failed: " .. tostring(info))
        end
    end)
end

local function mark()
    if input_active then return end
    local t = mp.get_property_number("time-pos")
    if not t then return end
    if start_time == nil then
        start_time = t
        osd(string.format("marker start: %.2fs", t))
    else
        local s, e = start_time, t
        start_time = nil
        if e <= s then
            osd("marker: end not after start; resetting")
            start_time = e
            return
        end
        prompt(s, e)
    end
end

mp.add_key_binding("m", "marker-mark", mark)
