local vim = vim
local api = vim.api

-- https://stackoverflow.com/questions/29072601/lua-string-gsub-with-a-hyphen
local function replace(str, what, with)
    what = string.gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
    with = string.gsub(with, "[%%]", "%%%%") -- escape replacement
    local v, _ = string.gsub(str, what, with)
    return v
end

vim.api.nvim_create_user_command("FormatLink", function()
    local line = api.nvim_get_current_line()
    local linenumber = vim.api.nvim_win_get_cursor(0)[1]
    local url = string.match(line, "[http://][https://][%w|%p]*")
    if url == nil or url == "" then
        return
    end

    -- local cmd = 'curl -s --fail "' .. url .. '" | pup "head > title text{}"'
    local cmd = { "xtitle", url }

    vim.fn.jobstart(cmd, {
        on_stdout = function(_, data, _)
            local linktext = string.format("[%s](%s)", data[1], url)
            local patchedline = replace(line, url, linktext)
            api.nvim_buf_set_lines(0, linenumber - 1, linenumber, false, { patchedline })
        end,
        stdout_buffered = true,
        stderr_buffered = true,
    })
end, {})
