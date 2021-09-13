vim.g._uname = 'Linux'
if vim.call("has", "mac") then
  vim.g._uname = 'macOS'
end

-- performance mode
vim.g._minimal = os.getenv("USER") ~= "rok"

P = function(v)
  print(vim.inspect(v))
  return v
end
