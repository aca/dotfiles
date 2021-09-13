vim.g._uname = 'Linux'
if vim.call("has", "mac") then
  vim.g._uname = 'macOS'
end


P = function(v)
  print(vim.inspect(v))
  return v
end
