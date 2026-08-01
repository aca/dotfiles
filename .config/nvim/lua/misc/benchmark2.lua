
local start = vim.fn.reltime()

local nvim_set_hl = vim.api.nvim_set_hl
for i = 1, 100000, 1 do
    nvim_set_hl(0, "@comment.warning", { bg = 3616810, fg = 11176553 })
end

start = vim.fn.reltime()
for i = 1, 100000, 1 do
    nvim_set_hl(0, "@comment.warning", { bg = 3616810, fg = 11176553 })
end
print(vim.fn.reltimestr(vim.fn.reltime(start)))

start = vim.fn.reltime()
for i = 1, 100000, 1 do
    vim.api.nvim_set_hl(0, "@comment.warning", { bg = 3616810, fg = 11176553 })
end
print(vim.fn.reltimestr(vim.fn.reltime(start)))


