local M = {}

---@class Pos
---@field line integer
---@field character integer

---@param point [integer, integer]
---@return Pos
function M.Pos_from_point(point)
    return { line = point[1] - 1, character = point[2] }
end

---@class Range
---@field start Pos
---@field end Pos

---@class Symbol
---@field kind string
---@field name string
---@field detail string
---@field level integer
---@field parent Symbol | nil
---@field children Symbol[]
---@field range Range

---@return Symbol
function M.Symbol_root()
    return {
        kind = "root",
        name = "<root>",
        detail = "",
        level = 0,
        parent = nil,
        children = {},
        range = {
            start = { line = 0, character = 0 },
            ["end"] = { line = -1, character = -1 }
        },
    }
end

---@param symbol Symbol
---@return string[]
function M.Symbol_path(symbol)
    local path = {}
    while symbol.level > 0 do
        path[symbol.level] = symbol.name
        symbol = symbol.parent
        assert(symbol ~= nil)
    end
    return path
end

---@param symbol Symbol
---@return string
function M.Symbol_inspect(symbol)
    return vim.inspect({
        kind = symbol.kind,
        name = symbol.name,
        details = symbol.detail,
        level = symbol.level,
        parent = (symbol.parent ~= nil and symbol.parent.name) or "nil",
        children = "[" .. tostring(#symbol.children) .. "]",
        range = symbol.range,
    })
end

return M
