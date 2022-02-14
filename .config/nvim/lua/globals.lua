local g = vim.g
-- g._minimal = os.getenv("VIM_MINIMAL") ~= ""
g._uname = "Linux"
if vim.call("has", "mac") then
    g._uname = "macOS"
end

g._minimal = os.getenv("_VIM_MODE") == "minimal" and true or false


