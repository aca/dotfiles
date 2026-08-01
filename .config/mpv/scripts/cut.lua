-- Lossless video cut script
-- Press 'x' to mark start, 'x' again to mark end, then 'y' to confirm cut.

local utils = require 'mp.utils'
local msg = require 'mp.msg'

local start_time = nil
local end_time = nil

local overlay = mp.create_osd_overlay("ass-events")
local hide_timer = nil

local function osd(text, duration)
    duration = duration or 3
    overlay.data = "{\\an8}" .. text:gsub("\n", "\\N")
    overlay:update()
    if hide_timer then hide_timer:kill() end
    hide_timer = mp.add_timeout(duration, function() overlay:remove() end)
end

local function fmt_time(t)
    local h = math.floor(t / 3600)
    local m = math.floor((t % 3600) / 60)
    local s = t % 60
    return string.format("%02d:%02d:%06.3f", h, m, s)
end

local function reset()
    start_time = nil
    end_time = nil
    mp.remove_key_binding("cut-confirm")
    mp.remove_key_binding("cut-cancel")
end

local function do_cut()
    local path = mp.get_property("path")
    if not path then
        osd("cut: no file")
        return
    end
    local dir, fname = utils.split_path(path)
    local base, ext = fname:match("^(.*)%.([^%.]+)$")
    if not base then
        base, ext = fname, "mkv"
    end
    local stem = string.format("%s_cut_%d", base, os.time())
    local out = utils.join_path(dir, stem .. "." .. ext)
    local tmp = utils.join_path(dir, "." .. stem .. ".tmp." .. ext)

    local args = {
        "ffmpeg", "-hide_banner", "-loglevel", "error", "-y",
        "-ss", fmt_time(start_time),
        "-to", fmt_time(end_time),
        "-i", path,
        "-c", "copy",
        "-avoid_negative_ts", "make_zero",
        tmp,
    }

    osd("cutting...", 3)
    msg.info(string.format("cut start: %s -> %s (%.3fs) src=%s tmp=%s out=%s",
        fmt_time(start_time), fmt_time(end_time), end_time - start_time, path, tmp, out))
    mp.command_native_async({
        name = "subprocess",
        args = args,
        playback_only = false,
        capture_stdout = true,
        capture_stderr = true,
    }, function(success, result, error)
        if success and result and result.status == 0 then
            local ok, rerr = os.rename(tmp, out)
            if ok then
                msg.info("cut done: " .. out)
                osd("cut saved: " .. out, 5)
            else
                msg.error("cut rename failed: " .. tostring(rerr))
                osd("cut rename failed: " .. tostring(rerr), 5)
                os.remove(tmp)
            end
        else
            local err = (result and result.stderr) or error or "unknown"
            msg.error("cut failed: " .. err)
            osd("cut failed: " .. err, 5)
            os.remove(tmp)
        end
    end)
    reset()
end

local function mark()
    local t = mp.get_property_number("time-pos")
    if not t then return end
    if start_time == nil then
        start_time = t
        osd("cut start: " .. fmt_time(t))
    else
        if t <= start_time then
            osd("end must be after start; resetting start")
            start_time = t
            return
        end
        end_time = t
        osd(string.format(
            "cut %s -> %s (%.2fs)\n[y] confirm  [n] cancel",
            fmt_time(start_time), fmt_time(end_time), end_time - start_time), 10)
        mp.add_forced_key_binding("y", "cut-confirm", do_cut)
        mp.add_forced_key_binding("n", "cut-cancel", function()
            osd("cut cancelled")
            reset()
        end)
    end
end

mp.add_key_binding("x", "cut-mark", mark)
