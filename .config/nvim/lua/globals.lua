local g = vim.g
-- g._minimal = os.getenv("VIM_MINIMAL") ~= ""
g._uname = "Linux"
if vim.call("has", "mac") then
	g._uname = "macOS"
end

if os.getenv("_VIM_MODE") == "minimal" then
	g._minimal = true
else
	g._minimal = false
end
