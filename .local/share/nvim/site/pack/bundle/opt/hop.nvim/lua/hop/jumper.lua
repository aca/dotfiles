--- Operation on the jump target
---@alias Jumper fun(jump_target:JumpTarget, opts:Options)

local M = {}
local fn = vim.fn
local api = vim.api

--- Move cursor to jump target
---@param jump_target JumpTarget
---@param opts Options
---@return boolean Moved or not
function M.move_cursor(jump_target, opts)
    local jt = jump_target

    if not api.nvim_win_is_valid(jt.window) then
        opts.echo(string.format('The window %d had disappeared', jt.window), vim.log.levels.ERROR)
        return false
    end
    api.nvim_set_current_win(jt.window)

    -- Keep consistent motion operator behavior with neovim
    if fn.mode(1) == 'no' then
        local wincur = api.nvim_win_get_cursor(0)
        local row = wincur[1]
        local col = wincur[2]
        if jt.cursor.row > row or (jt.cursor.row == row and jt.cursor.col > col) then
            jt.cursor.col = jt.cursor.col + 1
        end
    end

    -- Update the jump list
    -- There is bug with set extmark neovim/neovim#17861
    -- api.nvim_buf_set_mark(jt.buffer, "'", jt.cursor.row, jt.cursor.col + jt.cursor.off, {})
    vim.cmd("normal! m'")

    -- Note that nvim_win_set_cursor() only supports virtualedit=all
    -- Must set cursor with setpos() that supports virtualedit=insert/block
    --api.nvim_win_set_cursor(jt.window, { jt.cursor.row, jt.cursor.col + jt.cursor.off })
    fn.setpos('.', { jt.buffer, jt.cursor.row, jt.cursor.col + 1, jt.cursor.off })
    fn.winrestview({ curswant = fn.virtcol('.') - 1 })
    opts.echo(
        string.format('Jump to [%s, %s, %s]', jt.cursor.row, jt.cursor.col + 1, jt.cursor.off),
        vim.log.levels.INFO,
        { is_cmd_msg = true }
    )

    return true
end

--- Move multicursor to jump target
---@param jump_target JumpTarget
---@param opts Options
---@return boolean Moved or not
function M.move_multicursor(jump_target, opts)
    local mc = require('multicursor-nvim')
    if not mc.cursorsEnabled() then
        return M.move_cursor(jump_target, opts)
    else
        local jt_cur = jump_target.cursor
        local dpos = {}

        -- Compute cursor distance
        mc.action(function(ctx)
            local mpos = ctx:mainCursor():getPos()
            ctx:forEachCursor(function(cur)
                local pos = cur:getPos()
                dpos[#dpos + 1] = { pos[1] - mpos[1], pos[2] - mpos[2], pos[3] - mpos[3] }
            end, { enabledCursors = true, disabledCursors = false })
        end)

        if not M.move_cursor(jump_target, opts) then
            return false
        end

        -- Add new cursors
        mc.clearCursors()
        mc.action(function(ctx)
            for _, d in ipairs(dpos) do
                local row = jt_cur.row + d[1]
                local col = jt_cur.col + d[2] + 1
                local off = jt_cur.off + d[3]
                ctx:addCursor():setPos({ row, col, off })
            end
        end)
        opts.echo(
            string.format('Move %d cursors to [%s, %s, %s]', #dpos, jt_cur.row, jt_cur.col + 1, jt_cur.off),
            vim.log.levels.INFO,
            { is_cmd_msg = true }
        )
    end

    return true
end

return M
