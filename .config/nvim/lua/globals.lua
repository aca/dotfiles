local g = vim.g
g._minimal = os.getenv("USER") ~= "rok"
g._uname = "Linux"
if vim.call("has", "mac") then
	g._uname = "macOS"
end
