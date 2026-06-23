local fn = vim.fn

---@alias char string

--- A permutation algorithm implementation
---
--- We have:
---     n, n > 0                   : The required number of permutations
---     z, z = #keys > 1           : The number of `keys`
---     y, 0 < y                   : For higher depth permutations (longer label)
---     x, 0 < x <= z^y            : For lower depth permutations (shorter label)
---     f(x,y) = x + (z^y - x) * z : The max number of possible permutations
--- Then:
---     f(x,y) >= n
---     --->    x <= (z^(y+1) - n) / (z - 1)
---     --->    y > log_z(n) - 1
--- Make:
---     min(y)
---     max(x)
---@class PermImpl
---@field keys char[] The characters for permutations
---@field permute fun(self, n:integer):string[]

local P = {}
P.__index = P

--- Compute `x` and `y`
---@param n number The required number of permutations
---@return integer x
---@return integer y
function P:_xy(n)
    local z = #self.keys
    if n <= z then
        return n, 1 -- s.t. y > 0
    end

    local y = math.log(n) / math.log(z) - 1
    y = math.ceil(y) -- s.t. x > 0 & min(y)
    local x = (math.pow(z, y + 1) - n) / (z - 1)
    x = math.floor(x) -- s.t. max(x), perfer more shorter permutation as labels
    return x, y
end

--- Generate permutations at the depth
---@param depth integer Means the permutation as label has `#label = depth`
function P:_gen(depth)
    if depth == 1 then
        self[depth] = self.keys -- `self[-depth]` is not required for depth = 1
        return
    end

    -- Generate indices for perms[i1, i2, ..., id]
    local indices = {}
    for _ = 1, depth - 1 do
        indices[#indices + 1] = 1 -- Make lua happy for 1-based index
    end
    indices[#indices + 1] = 0

    -- Generate permutations
    local z = #self.keys
    local pos_perms = {}
    local neg_perms = {}
    for k = 1, math.pow(z, depth) do
        for d = depth, 1, -1 do
            indices[d] = indices[d] + 1
            if indices[d] <= z then
                break
            else
                indices[d] = 1
            end
        end

        local pos = ''
        local neg = ''
        for d = 1, depth - 1 do
            pos = pos .. self.keys[indices[d]]
            neg = neg .. self.keys[z - indices[d] + 1]
        end
        pos_perms[k] = pos .. self.keys[indices[depth]]
        neg_perms[k] = neg .. self.keys[indices[depth]]
    end
    self[depth] = pos_perms
    self[-depth] = neg_perms
end

--- Generate permutations
---@param n number The required number of permutations
function P:permute(n)
    local x, y = self:_xy(n)
    -- print(string.format('x = %d, y = %d, z = %d', x, y, #self.keys))

    -- Merge permutations from two level depth
    local perms = {}
    local dlo = y
    local dhi = dlo + 1
    if not self[dlo] then
        self:_gen(dlo)
    end
    vim.list_extend(perms, self[dlo], 1, x)
    if #perms < n then
        if not self[dhi] then
            self:_gen(dhi)
        end
        vim.list_extend(perms, self[-dhi], 1, n - #perms)

        -- ONLY FOR TEST: keep insistent distribution with original permutation algorithm
        -- local z = #self.keys
        -- local reset = n - #perms
        -- local reset_idx = #self[dhi] - reset + 1
        -- local reverse_num = reset % z
        -- local reverse_idx = math.floor(reset_idx - z + reverse_num)
        -- local reverse = vim.list_slice(self[dhi], reverse_idx, reverse_idx + reverse_num - 1)
        -- for k = 1, #reverse do
        --     perms[#perms + 1] = reverse[k]
        -- end
        -- vim.list_extend(perms, self[dhi], reset_idx + reverse_num)
    end
    return perms
end

local M = {}

--- Generate permutations from Options.keys
---@alias PermGenerator fun(keystr:string, n:integer):string[]

---@type table<string,PermImpl>
local cache_permutations = {}

--- Generate permutations from chars
---@param keystr string
---@param n number The number permutations to generate
---@return string[]
function M.permute(keystr, n)
    if not cache_permutations[keystr] then
        cache_permutations[keystr] = setmetatable({ keys = fn.split(keystr, '\\zs') }, P)
    end
    local cache = cache_permutations[keystr]
    return cache:permute(n)
end

return M
