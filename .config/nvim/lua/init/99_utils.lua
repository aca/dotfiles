local vim = vim
local function utils()
    function _G.P(...)
        vim.pretty_print(...)
    end
end
