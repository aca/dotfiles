local M = {}
local api = vim.api

---@enum HintDirection
M.HintDirection = {
    BEFORE_CURSOR = 1,
    AFTER_CURSOR = 2,
}

---@enum RenderPriority
M.RenderPriority = {
    AREA = 65510, -- The unmatched area
    JUMP = 65520, -- The match string for jump target
    HINT = 65530, -- The hint keys
}

--- Echo levels for M.echo
M.EchoLevels = {
    [vim.log.levels.TRACE] = 'Title',
    [vim.log.levels.DEBUG] = 'Title',
    [vim.log.levels.INFO] = 'Title',
    [vim.log.levels.WARN] = 'Question',
    [vim.log.levels.ERROR] = 'Error',
}

---@class EchoOptions
---@field is_cmd_msg boolean Message is recommended to show at cmdline (wait for `getcharstr()` mainly)

--- Echo message
---@param msg string|fun()
---@param level vim.log.levels
---@param opts nil|EchoOptions
function M.echo(msg, level, opts)
    if vim.is_callable(msg) then
        return msg()
    end
    if opts and opts.is_cmd_msg then
        if M.EchoLevels[level] then
            api.nvim_echo({ { msg, M.EchoLevels[level] } }, false, {})
            vim.cmd.redraw()
        end
    else
        vim.notify(msg, level, opts)
    end
end

---@class Options
---@field keys string Chars to generate hint lable for jump targets
---@field key_quit string The char to quit hop operation
---@field key_delete string The char to delete one inputed char and re-select hint lable for jump targets
---@field match_mappings table Extend match capabilities (For matcher._checkout_mappings and matcher.chars)
---@field distance Distancer
---@field permute PermGenerator
---@field jump Jumper
---@field hint_direction HintDirection|nil Hint direction, nil means hint all directions
---@field hint_position number Change hint position among the matched string, 0.0 for left and 1.0 for right (MatchResult.b/e)
---@field hint_reverse boolean|nil Reverse hint position to make shorter hint lables placed further
---@field hint_upper boolean|nil Display hint keys in upper
---@field hl_matched boolean|nil Highlight the matched string inside [MatchResult.b, MatchResult.e]
---@field hl_unmatched boolean|nil Highlight the unmatched part of the buffer (i.e. highlight the background)
---@field auto_setup_hl boolean|nil Setup highlights for ColorScheme event
---@field auto_jump_one_target boolean|nil Auto jump when there's only one jump target
---@field current_line_only boolean|nil Work for current cursor line only
---@field current_window_only boolean|nil Work for current window only
---@field exclude_line nil|fun(hwin, hbuf, lnum:WindowRow, folded:boolean):boolean Exclude buffer line from hop operations (folded means take an empty string as a folded line)
---@field exclude_window nil|fun(hwin, hbuf):boolean Exclude window from hop operations
---@field echo fun(msg:string|fun(), level:vim.log.levels, opts:nil|EchoOptions) Message handler
---@field msg_no_targets string|fun() Show message when there's no jump targets

---@type Options
M._default_opts = {
    keys = 'asdghklqwertyuiopzxcvbnmfj',
    key_quit = '<Esc>',
    key_delete = '<Bs>',
    match_mappings = {},
    distance = require('hop.hinter').manhattan,
    permute = require('hop.permutation').permute,
    jump = require('hop.jumper').move_cursor,
    hint_direction = nil,
    hint_position = 0.0,
    hint_reverse = false,
    hint_upper = false,
    hl_matched = false,
    hl_unmatched = true,
    auto_setup_hl = true,
    auto_jump_one_target = true,
    current_line_only = false,
    current_window_only = false,
    exclude_line = nil,
    exclude_window = nil,
    echo = M.echo,
    msg_no_targets = 'No target was found...',
}

--- Check options and revise options in-place
---@param opts Options
---@return Options
function M.check_opts(opts)
    if opts.hint_position then
        opts.hint_position = math.max(0.0, math.min(opts.hint_position, 1.0))
    end
    if opts.key_quit then
        opts.key_quit = api.nvim_replace_termcodes(opts.key_quit, true, false, true)
    end
    if opts.key_delete then
        opts.key_delete = api.nvim_replace_termcodes(opts.key_delete, true, false, true)
    end
    return opts
end

function M.setup_highlights()
    local set_hl = api.nvim_set_hl

    -- Highlight the mono-sequence keys (i.e. sequence of 1)
    set_hl(0, 'HopNextKey', { fg = '#ff007c', bold = true, ctermfg = 198, cterm = { bold = true }, default = true })

    -- Highlight the first key in a sequence
    set_hl(0, 'HopNextKey1', { fg = '#00dfff', bold = true, ctermfg = 45, cterm = { bold = true }, default = true })

    -- Highlight the second and remaining keys in a sequence
    set_hl(0, 'HopNextKey2', { fg = '#2b8db3', ctermfg = 33, default = true })

    -- Highlight the matched string between start from MatchResult.b to MatchResult.e
    set_hl(0, 'HopMatched', { fg = '#b8bb26', ctermfg = 142, default = true })

    -- Highlight the unmatched part of the buffer (i.e. highlight the background)
    set_hl(0, 'HopUnmatched', { fg = '#666666', sp = '#666666', ctermfg = 242, default = true })
end

function M.setup(opts)
    M._default_opts = vim.tbl_extend('force', M._default_opts, opts)
    M.check_opts(M._default_opts)

    M.setup_highlights()
    if M._default_opts.auto_setup_hl then
        api.nvim_create_autocmd('ColorScheme', {
            group = api.nvim_create_augroup('Hop.SetupHighlights', { clear = true }),
            callback = M.setup_highlights,
        })
    end
end

return M
