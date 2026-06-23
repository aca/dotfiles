local M = {}
local fn = vim.fn
local api = vim.api
local config = require('hop.config')
local matcher = require('hop.matcher')
local hinter = require('hop.hinter')

-- Allows to overide options
---@param opts Options|nil
---@return Options
function M.get_opts(opts)
    opts = config.check_opts(opts and vim.deepcopy(opts) or {})
    local mode = fn.mode(1)
    if mode ~= 'n' and mode ~= 'nt' then
        opts.current_window_only = true
    end
    return setmetatable(opts, { __index = config._default_opts })
end

--- Wrap hop functionalities
---@param match Matcher
---@param opts Options|nil
function M.wrap(match, opts)
    opts = M.get_opts(opts)
    local ht = hinter.new(opts) -- Create a hinter
    local jts = ht:collect(match) -- Collect jump targets
    local jt = ht:select(jts) -- Select one jump target
    if jt then
        opts.jump(jt, opts) -- Jump to selected jump target
    end
end

function M.char(opts)
    (opts and opts.echo or config._default_opts.echo)('Hop char:', vim.log.levels.WARN, { is_cmd_msg = true })
    local ok, c = pcall(fn.getcharstr)
    if not ok then -- Interrupted by <C-c>
        return
    end
    local mappings = opts and opts.match_mappings or config._default_opts.match_mappings
    M.wrap(matcher.chars(c, true, mappings), opts)
end

function M.word(opts)
    M.wrap(matcher.word, opts)
end

function M.anywhere(opts)
    M.wrap(matcher.anywhere, opts)
end

function M.line_start(opts)
    M.wrap(matcher.line_start, opts)
end

function M.vertical(opts)
    M.wrap(matcher.vertical, opts)
end

function M.setup(opts)
    opts = opts or {}
    config.setup(opts)

    local hd = config.HintDirection
    local all = { hint_direction = nil, current_line_only = false, current_window_only = false }
    local cl = { hint_direction = nil, current_line_only = true, current_window_only = true }
    local cw = { hint_direction = nil, current_line_only = false, current_window_only = true }
    local ac = { hint_direction = hd.AFTER_CURSOR, current_line_only = false, current_window_only = true }
    local accl = { hint_direction = hd.AFTER_CURSOR, current_line_only = true, current_window_only = true }
    local bc = { hint_direction = hd.BEFORE_CURSOR, current_line_only = false, current_window_only = true }
    local bccl = { hint_direction = hd.BEFORE_CURSOR, current_line_only = true, current_window_only = true }

    for _, item in ipairs({
        { 'HopChar', M.char },
        { 'HopWord', M.word },
        { 'HopAnywhere', M.anywhere },
    }) do
        local name = item[1]
        local func = item[2]
        -- stylua: ignore start
        api.nvim_create_user_command(name, function() func(all) end, {})
        api.nvim_create_user_command(name .. 'CL', function() func(cl) end, {})
        api.nvim_create_user_command(name .. 'CW', function() func(cw) end, {})
        api.nvim_create_user_command(name .. 'AC', function() func(ac) end, {})
        api.nvim_create_user_command(name .. 'ACCL', function() func(accl) end, {})
        api.nvim_create_user_command(name .. 'BC', function() func(bc) end, {})
        api.nvim_create_user_command(name .. 'BCCL', function() func(bccl) end, {})
        -- stylua: ignore end
    end

    for _, item in ipairs({
        { 'HopLineStart', M.line_start },
        { 'HopVertical', M.vertical },
    }) do
        local name = item[1]
        local func = item[2]
        -- stylua: ignore start
        api.nvim_create_user_command(name, function() func(all) end, {})
        api.nvim_create_user_command(name .. 'CW', function() func(cw) end, {})
        api.nvim_create_user_command(name .. 'AC', function() func(ac) end, {})
        api.nvim_create_user_command(name .. 'BC', function() func(bc) end, {})
        -- stylua: ignore end
    end
end

return M
