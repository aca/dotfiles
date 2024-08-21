
local start = vim.fn.reltime()
start = vim.fn.reltime()

for i = 1, 10000, 1 do
    _ = vim.api.nvim_get_current_line()
end

print(vim.fn.reltimestr(vim.fn.reltime(start)))

start = vim.fn.reltime()

for i = 1, 10000, 1 do
    _ = vim.fn.getline('.')
end

print(vim.fn.reltimestr(vim.fn.reltime(start)))


