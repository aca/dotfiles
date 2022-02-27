vim.cmd("packadd dial.nvim")

-- require("dial").config.searchlist.normal = {
--     "number#decimal",
--     "number#hex",
--     "number#binary",
--     "number#decimal#fixed#zero",
--     "number#decimal#fixed#space",
--     "date#[%Y/%m/%d]",
--     "markup#markdown#header",
--     "char#alph#small#str",
-- }

local augend = require("dial.augend")
require("dial.config").augends:register_group{
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
  },
  typescript = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.new{ elements = {"let", "const"} },
  },
  visual = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
  },
}
