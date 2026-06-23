local LogLevels = {
    TRACE = 0,
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4,
    OFF = 5,
}

local LogHighlights = {
    [1] = 'Comment',
    [2] = 'None',
    [3] = 'WarningMsg',
    [4] = 'ErrorMsg',
}

local M = {}

--- @param level integer
--- @param msg string
local function log(level, msg)
    local msg_lines = vim.split(msg, '\n', { plain = true })
    local msg_chunks = {}
    for _, line in ipairs(msg_lines) do
        table.insert(msg_chunks, {
            string.format('[lsp-progress] %s\n', line),
            LogHighlights[level],
        })
    end
    -- vim.api.nvim_echo(msg_chunks, false, {})
    -- vim.notify(msg, level)
    -- print(msg)
end

--- @param fmt string
--- @param ... any
M.debug = function(fmt, ...)
    log(LogLevels.DEBUG, string.format(fmt, ...))
end

--- @param fmt string
--- @param ... any
M.info = function(fmt, ...)
    log(LogLevels.INFO, string.format(fmt, ...))
end

--- @param fmt string
--- @param ... any
M.warn = function(fmt, ...)
    log(LogLevels.WARN, string.format(fmt, ...))
end

--- @param fmt string
--- @param ... any
M.error = function(fmt, ...)
    log(LogLevels.ERROR, string.format(fmt, ...))
end

return M
