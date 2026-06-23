---@class Matcher
---@field oneshot boolean Only match once on one line
---@field match fun(s:string, wctx:WindowContext, lctx:LineContext):MatchResult|nil Perform match operation on the line `s`

---@class MatchResult
---@field b WindowCol The begin column of matched area within one line
---@field e WindowCol The end column of matched area within one line
---@field off WindowCell Always zero, unless 'virtualedit' is enabled so we can jump to blank cell
---@field virt WindowCell|nil Always nil, unless 'virtualedit' is enabled so we can place hint at blank cell

local M = {}
local fn = vim.fn
local window = require('hop.window')

--- Create MatchResult conveniently from vim.regex:match_str
---@return MatchResult|nil
local function match_result(b, e, f, v)
    if b and e then
        return {
            b = b,
            e = e,
            off = f or 0,
            virt = v,
        }
    end
end

--- Checkout match-mappings with key from each pattern character
---@param pat string Pattern to search inputed from user
---@param match_mappings table Options.match_mappings
---@return string Pattern for regex match
function M.checkout_mappings(pat, match_mappings)
    local dict_pat = ''

    for k = 1, #pat do
        local char = pat:sub(k, k)
        local dict_char_pat = ''
        -- Checkout dict-char pattern from each mapping dict
        for _, map in ipairs(match_mappings) do
            local val = require('hop.mappings.' .. map)[char]
            if val ~= nil then
                dict_char_pat = dict_char_pat .. val
            end
        end

        if dict_char_pat ~= '' then
            dict_pat = dict_pat .. '[' .. dict_char_pat .. ']'
        end
    end

    return dict_pat
end

--- Search pattern by regex
---@param pat string
---@param plain boolean|nil
---@param oneshot boolean|nil
---@return Matcher
function M.by_regex(pat, plain, oneshot)
    if plain then
        pat = fn.escape(pat, '\\/.$^~[]')
    end

    local regex = vim.regex(pat)
    return {
        oneshot = oneshot,
        match = function(s)
            return match_result(regex:match_str(s))
        end,
    }
end

--- Match chars with smart case
---@param pat string
---@param plain boolean
---@param match_mappings table Options.match_mappings
---@return Matcher
function M.chars(pat, plain, match_mappings)
    local pat_case = '\\c'
    if pat:match('%u') then
        pat_case = '\\C'
    end
    local pat_mappings = M.checkout_mappings(pat, match_mappings)

    if plain then
        pat = fn.escape(pat, '\\/.$^~[]')
    end
    if pat_mappings ~= '' then
        pat = string.format([[\(%s\)\|\(%s\)]], pat, pat_mappings)
    end
    pat = pat .. pat_case

    local regex = vim.regex(pat)
    return {
        oneshot = false,
        match = function(s)
            return match_result(regex:match_str(s))
        end,
    }
end

--- Match word start
---@type Matcher
M.word = M.by_regex('\\k\\+')

--- Match anywhere
---@type Matcher
M.anywhere = M.by_regex('\\v(<.|^$)|(.>|^$)|(\\l)\\zs(\\u)|(_\\zs.)|(#\\zs.)')

--- Match line start with whitespace characters skipped
---@type Matcher
M.line_start = M.by_regex('\\S\\|$', false, true)

--- Match vertical cursor column
---@type Matcher
M.vertical = {
    oneshot = true,
    match = function(s, wctx, lctx)
        if window.is_active_line(wctx, lctx) then
            return
        end

        local virt = wctx.virtualedit and wctx.cursor.virt or nil
        local line_cells = fn.strdisplaywidth(lctx.line)
        local cursor_cells = wctx.win_offset + wctx.cursor.virt
        if cursor_cells > line_cells then
            local line_len = string.len(lctx.line) - lctx.col_bias
            if not virt then
                -- When virtualedit is enabled, the line EOL is taken as the last line cell that can jump to,
                -- so minus one to take the last line character as the last line cell when virtualedit is disabled.
                line_len = line_len - 1
            end
            return match_result(line_len, line_len + 1, cursor_cells - line_cells, virt)
        else
            local idx = window.cell2char(s, wctx.cursor.virt)
            local col = fn.byteidx(s, idx)
            return match_result(col, col + 1, 0, virt)
        end
    end,
}

return M
