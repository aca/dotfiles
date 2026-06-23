local M = {}

--@param buf winbuf
--@param line string
function M.Header()
    local line = unpack(vim.api.nvim_buf_get_lines(0, 0, 1, true))
    local header = {}
    local length = 0
    for i = 1, #line do
        if line:sub(i, i) ~= "," then
            length = length + 1
        else
            table.insert(header, length)
            length = 0
        end
    end
    -- fixbug
    if length ~= 0 then
        table.insert(header, length)
    end
    return header
end
return M
