local mp = require 'mp'
local utils = require 'mp.utils'

local start_time = nil
local playlist_edl_path = mp.command_native({"expand-path", "/mnt/playlist.edl"})

local function show_message(text, duration)
    mp.osd_message(text, duration or 3)
end

local function mark_start()
    start_time = mp.get_property_number("time-pos")
    if start_time then
        show_message(string.format("Start marked at: %.2fs", start_time))
    else
        show_message("Error: Could not get current time position")
    end
end

local function ensure_edl_header()
    local file = io.open(playlist_edl_path, "r")
    local needs_header = true

    if file then
        local first_line = file:read("*line")
        if first_line == "# mpv EDL v0" then
            needs_header = false
        end
        file:close()
    end

    if needs_header then
        local existing_content = ""
        local file_read = io.open(playlist_edl_path, "r")
        if file_read then
            existing_content = file_read:read("*all")
            file_read:close()
        end

        local file_write = io.open(playlist_edl_path, "w")
        if file_write then
            file_write:write("# mpv EDL v0\n" .. existing_content)
            file_write:close()
        end
    end
end

local function mark_end_and_add()
    if not start_time then
        show_message("Error: No start time marked. Press 'a' to mark start first.")
        return
    end

    local end_time = mp.get_property_number("time-pos")
    if not end_time then
        show_message("Error: Could not get current time position")
        return
    end

    if end_time <= start_time then
        show_message("Error: End time must be after start time")
        return
    end

    local filename = mp.get_property("path")
    if not filename then
        show_message("Error: No file loaded")
        return
    end

    local duration = end_time - start_time
    local edl_line = string.format("%s,%.3f,%.3f", filename, start_time, duration)

    ensure_edl_header()

    local file = io.open(playlist_edl_path, "a")
    if file then
        file:write(edl_line .. "\n")
        file:close()
        show_message(string.format("Added segment: %.2fs-%.2fs (%.2fs duration)", start_time, end_time, duration))
        start_time = nil
    else
        show_message("Error: Could not write to playlist.edl")
    end
end

local function reset_marks()
    start_time = nil
    show_message("Marks cleared")
end

local function show_status()
    if start_time then
        local current_time = mp.get_property_number("time-pos") or 0
        show_message(string.format("Start: %.2fs | Current: %.2fs | Duration: %.2fs",
                    start_time, current_time, current_time - start_time))
    else
        show_message("No start time marked")
    end
end

mp.add_key_binding("a", "mark-start", mark_start)
mp.add_key_binding("s", "mark-end-and-add", mark_end_and_add)
mp.add_key_binding("d", "reset-marks", reset_marks)
mp.add_key_binding("f", "show-status", show_status)

mp.register_event("file-loaded", function()
    start_time = nil
end)

show_message("EDL Segments loaded. Keys: 'a'=mark start, 's'=mark end & add, 'd'=reset, 'f'=status")
