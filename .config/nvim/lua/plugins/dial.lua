vim.cmd("packadd dial.nvim")

require("dial").config.searchlist.normal = {
	"number#decimal",
	"number#hex",
	"number#binary",
	"number#decimal#fixed#zero",
	"number#decimal#fixed#space",
	"date#[%Y/%m/%d]",
	"markup#markdown#header",
	"char#alph#small#str",
}
