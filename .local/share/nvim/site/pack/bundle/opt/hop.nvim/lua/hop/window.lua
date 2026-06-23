---@alias WindowRow integer 1-based line row at window
---@alias WindowCol integer 0-based column at window, also as string byte index
---@alias WindowCell integer 0-based displayed cell column at window; often computed via `strdisplaywidth()`
---@alias WindowChar integer 0-based character index at string
--- For multi-byte character, there may be WindowCol ~= WindowCell ~= WindowChar like below showed
--- ```
--- LineString:   a #### b     => '####' is a 4-bytes character takes 2-cells
--- WindowCol:    0 1234 5
--- WindowCell:   0 1 2  3
--- WindowChar:   0 1    2
--- ```
---
--- Infos for some neovim api:
--- * 1-based line, 0-based column: nvim_win_get_cursor(), nvim_win_set_cursor()
--- * 1-based line, 1-based column: getcurpos(), setpos()
--- * 0-based line, end-exclusive: nvim_buf_get_lines()
--- * 0-based line, end-inclusive; 0-based column, end-exclusive: nvim_buf_set_extmark()
--- * 1-based line: foldclosedend()
--- * 0-based character index: charidx(), strcharpart()
--- * 0-based byte index: byteidx(), strpart()

---@class Cursor Cursor position and display information
---@field row WindowRow
---@field col WindowCol
---@field off WindowCell Jump to blank cell when 'virtualedit' is enabled
---@field virt WindowCell|nil The cursor cell column displayed relative to the WindowContext.win_offset

---@class LineContext
---@field row WindowRow
---@field line string
---@field line_cliped string
---@field col_bias WindowCol Bias column of the left clipped line
---@field off_bias WindowCell Bias cell column of the left clipped blank cells for 'virtualedit' is enabled

--- Mark window range with Cursor.row and Cursor.col only
---@class WindowRange
---@field top_left Cursor Inclusive
---@field bot_right Cursor Exclusive

--- The Cursor and LineContext under WindowContext:
--- ```
---                       | virt         |
--- | col_bias            |        | off |
--- 1*********************|========|~~~~~$~~|
--- | win_offset          | win_width       |
---
---            | off                     |
--- | col_bias | off_bias | virt         |
--- 2**********|~~~~~~~~~~|~~~~~~~~~~~~~~$~~|
--- | win_offset          | win_width       |
--- ```
--- '1' : line 1 with long line string
--- '2' : line 2 with short line string
--- '*' : line string hidded to window left
--- '=' : line string displayed on window
--- '~' : blank cells without any text after line string
--- '$' : cursor with 'virtualedit' enabled
---
---@class WindowContext
---@field hwin integer
---@field hbuf integer
---@field cursor Cursor
---@field win_range WindowRange Window range for context area
---@field win_width WindowCell Window cell width excluding fold, sign and number columns
---@field win_offset WindowCell First cell column displayed at window (also is the cell number hidden to window left)
---@field virtualedit boolean The 'virtualedit' is enabled or not

local M = {}
local fn = vim.fn
local api = vim.api

--- Convert WindowRow to extmark line
---@param row WindowRow
function M.row2extmark(row)
    return row - 1
end

--- Convert WindowCol to extmark column
---@param col WindowCol
function M.col2extmark(col)
    return col
end

--- Convert Cursor to extmark position
---@param pos Cursor
function M.pos2extmark(pos)
    return pos.row - 1, pos.col
end

--- Get the character index at the window column
---@param line string
---@param cell WindowCell
---@return WindowChar
function M.cell2char(line, cell)
    if cell <= 0 then
        return 0
    end

    local line_cells = fn.strdisplaywidth(line)
    local line_chars = fn.strchars(line)
    -- No multi-byte character
    if line_cells == line_chars then
        return cell
    end
    -- Line is shorter than cell, all line should include
    if line_cells <= cell then
        return line_chars
    end

    local lst
    -- Line is very long
    if line_chars >= cell then
        -- Split the line to individual characters
        lst = fn.split(fn.strcharpart(line, 0, cell), '\\zs')
    else
        lst = fn.split(line, '\\zs')
    end

    local i, w = 0, 0
    repeat
        i = i + 1
        w = w + fn.strdisplaywidth(lst[i])
    until w >= cell
    -- If w < cell, that is the i-th multi-byte character is after the cell
    return w == cell and i or i - 1
end

--- Report virtualedit is enabled or not
---@return boolean
local function is_virtualedit_enabled(hwin)
    local ve = vim.wo[hwin].virtualedit
    local mode = fn.mode()
    return (ve == 'all') or (ve == 'insert' and mode == 'i') or (ve == 'block' and mode == '\22')
end

--- Get information about the window and the cursor
---@param hwin number
---@param hbuf number
---@return WindowContext
local function window_context(hwin, hbuf)
    local win_info = fn.getwininfo(hwin)[1]
    local win_view = api.nvim_win_call(hwin, fn.winsaveview)
    local cursor_pos = fn.getcurpos(hwin)
    ---@type Cursor
    local cursor = {
        row = cursor_pos[2],
        col = cursor_pos[3] - 1,
        off = cursor_pos[4],
        virt = nil,
    }
    local cursor_line = api.nvim_buf_get_lines(hbuf, cursor.row - 1, cursor.row, false)[1]
    cursor.virt = fn.strdisplaywidth(cursor_line:sub(1, cursor.col)) + cursor.off - win_view.leftcol

    local bottom_line = api.nvim_buf_get_lines(hbuf, win_info.botline - 1, win_info.botline, false)[1]
    local right_column = string.len(bottom_line)

    local win_width = nil
    if not vim.wo.wrap then
        -- Number of columns occupied by any 'foldcolumn', 'signcolumn' and line number in front of the text
        win_width = win_info.width - win_info.textoff
    end

    return {
        hwin = hwin,
        hbuf = hbuf,
        cursor = cursor,
        win_range = {
            top_left = { row = win_info.topline, col = 0 },
            bot_right = { row = win_info.botline, col = right_column },
        },
        win_width = win_width,
        win_offset = win_view.leftcol,
        virtualedit = is_virtualedit_enabled(hwin),
    }
end

-- Get all windows context
---@param opts Options
---@return WindowContext[] The first is always current window
function M.get_windows_context(opts)
    ---@type WindowContext[]
    local contexts = {}

    -- Generate contexts of windows
    local cur_hwin = api.nvim_get_current_win()
    local cur_hbuf = api.nvim_win_get_buf(cur_hwin)

    contexts[1] = window_context(cur_hwin, cur_hbuf)

    if opts.current_window_only then
        return contexts
    end

    -- Get the context for all the windows in current tab
    for _, w in ipairs(api.nvim_tabpage_list_wins(0)) do
        local valid_win = api.nvim_win_is_valid(w)
        local focusable_win = api.nvim_win_get_config(w).focusable
        if valid_win and focusable_win and w ~= cur_hwin then
            local b = api.nvim_win_get_buf(w)
            if not (vim.is_callable(opts.exclude_window) and opts.exclude_window(w, b)) then
                contexts[#contexts + 1] = window_context(w, b)
            end
        end
    end

    return contexts
end

--- Collect visible and unfold lines of window context
---@param win_ctx WindowContext
---@param opts Options
---@return LineContext[]
function M.get_lines_context(win_ctx, opts)
    ---@type LineContext[]
    local lines = {}

    local lnr = win_ctx.win_range.top_left.row
    while lnr <= win_ctx.win_range.bot_right.row do
        local fold_end = api.nvim_win_call(win_ctx.hwin, function()
            return fn.foldclosedend(lnr)
        end)
        ---@type LineContext
        local line_ctx = {
            row = lnr,
            line = '',
            line_cliped = '',
            col_bias = 0,
            off_bias = 0,
        }
        local folded = fold_end ~= -1
        if folded then
            -- Skip folded lines
            -- Let line = '' to take the first folded line as an empty line, where only the first column can move to
            lnr = fold_end
        else
            line_ctx.line = api.nvim_buf_get_lines(win_ctx.hbuf, lnr - 1, lnr, false)[1]
        end
        if not (vim.is_callable(opts.exclude_line) and opts.exclude_line(win_ctx.hwin, win_ctx.hbuf, lnr, folded)) then
            lines[#lines + 1] = line_ctx
        end
        lnr = lnr + 1
    end

    return lines
end

---@param win_ctx WindowContext
function M.is_active_window(win_ctx)
    return win_ctx.hwin == api.nvim_get_current_win()
end

---@param win_ctx WindowContext
---@param line_ctx LineContext
function M.is_cursor_line(win_ctx, line_ctx)
    return win_ctx.cursor.row == line_ctx.row
end

---@param win_ctx WindowContext
---@param line_ctx LineContext
function M.is_active_line(win_ctx, line_ctx)
    return win_ctx.hwin == api.nvim_get_current_win() and win_ctx.cursor.row == line_ctx.row
end

--- Clip the window context area
---@param win_ctx WindowContext
---@param opts Options
function M.clip_window_context(win_ctx, opts)
    if opts.current_line_only then
        local row = win_ctx.cursor.row
        local line = api.nvim_buf_get_lines(win_ctx.hbuf, row - 1, row, false)[1]

        win_ctx.win_range.top_left = { row = row, col = 0, off = 0 }
        win_ctx.win_range.bot_right = { row = row, col = string.len(line), off = 0 }
    end

    local row = win_ctx.cursor.row
    local line = api.nvim_buf_get_lines(win_ctx.hbuf, row - 1, row, false)[1]
    local line_len = string.len(line)

    if opts.current_line_only then
        win_ctx.win_range.top_left = { row = row, col = 0, off = 0 }
        win_ctx.win_range.bot_right = { row = row, col = line_len, off = 0 }
    end
    if opts.hint_direction == require('hop.config').HintDirection.BEFORE_CURSOR then
        if win_ctx.cursor.col + 1 <= line_len then
            -- For non-empty lines we have to increase it so we include the cursor
            win_ctx.win_range.bot_right = { row = row, col = win_ctx.cursor.col + 1, off = 0 }
        else
            win_ctx.win_range.bot_right = win_ctx.cursor
        end
    elseif opts.hint_direction == require('hop.config').HintDirection.AFTER_CURSOR then
        win_ctx.win_range.top_left = win_ctx.cursor
    end
end

--- Clip line context within window
---@param line_ctx LineContext
---@param win_ctx WindowContext
---@param opts Options
function M.clip_line_context(win_ctx, line_ctx, opts)
    ---@type WindowCell
    local line_cells = fn.strdisplaywidth(line_ctx.line)
    local end_cell = line_cells
    if win_ctx.win_width ~= nil then
        end_cell = win_ctx.win_offset + win_ctx.win_width
    end

    -- Handle cliped line with cell2char for multiple-bytes chars
    ---@type WindowChar
    local left_idx = M.cell2char(line_ctx.line, win_ctx.win_offset)
    ---@type WindowChar
    local right_idx = M.cell2char(line_ctx.line, end_cell)
    local line_cliped = fn.strcharpart(line_ctx.line, left_idx, right_idx - left_idx)
    ---@type WindowCol
    local col_bias = fn.byteidx(line_ctx.line, left_idx)

    if line_ctx.row == win_ctx.cursor.row then
        if opts.hint_direction == require('hop.config').HintDirection.AFTER_CURSOR then
            line_cliped = line_cliped:sub(1 + win_ctx.cursor.col - col_bias)
            col_bias = win_ctx.cursor.col
        elseif opts.hint_direction == require('hop.config').HintDirection.BEFORE_CURSOR then
            line_cliped = line_cliped:sub(1, 1 + win_ctx.cursor.col - col_bias)
        end
    end

    ---@type WindowCell
    local off_bias = 0
    if win_ctx.win_offset > line_cells then
        off_bias = win_ctx.win_offset - line_cells
    end

    line_ctx.line_cliped = line_cliped
    line_ctx.col_bias = col_bias
    line_ctx.off_bias = off_bias
end

return M
