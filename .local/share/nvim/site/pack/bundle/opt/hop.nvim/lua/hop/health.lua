local M = {}

function M.check()
    local health = vim.health or require('health')
    local hop = require('hop')
    local opts = hop.get_opts()
    local keys_num = #opts.keys

    health.start('Ensure the number of opts.keys > 1')
    local msg = 'opts.keys number = ' .. tostring(keys_num)
    if keys_num <= 1 then
        health.error(msg)
    else
        health.ok(msg)
    end

    health.start('Ensure each key of opts.keys length = 1')
    local had_errors = false
    for i = 1, keys_num do
        local key = opts.keys:sub(i, i)
        if #key ~= 1 then
            had_errors = true
            health.error(string.format('Key %s length = %d', key, #key))
        end
    end
    if not had_errors then
        health.ok('All keys length = 1')
    end

    health.start('Ensure each key of opts.keys is unique')
    had_errors = false
    local existing_keys = {}
    for i = 1, keys_num do
        local key = opts.keys:sub(i, i)
        if existing_keys[key] then
            had_errors = true
            health.error(string.format('Key %s appears more than once', key))
        else
            existing_keys[key] = true
        end
    end
    if not had_errors then
        health.ok('All keys are unique')
    end
end

return M
