local M = {}

---@param seq string[] Char sequence
function M.override_keyseq(seq, closure)
    local mocked = vim.fn.getcharstr

    local idx = 0
    vim.fn.getcharstr = function()
        idx = idx + 1
        return seq[idx]
    end
    local r = closure()

    vim.fn.getcharstr = mocked
    return r
end

return M
