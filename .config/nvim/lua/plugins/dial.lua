vim.cmd("packadd dial.nvim")

local augend = require("dial.augend")
require("dial.config").augends:register_group({
	default = {
		augend.integer.alias.decimal,
		augend.integer.alias.hex,
		augend.date.alias["%Y/%m/%d"],
	},
	-- typescript = {
	--   augend.integer.alias.decimal,
	--   augend.integer.alias.hex,
	--   -- augend.constant.new{ elements = {"let", "const"} },
	-- },
	visual = {
		augend.integer.alias.decimal,
		augend.integer.alias.hex,
		augend.date.alias["%Y/%m/%d"],
		augend.constant.alias.alpha,
		augend.constant.alias.Alpha,
	},
})
