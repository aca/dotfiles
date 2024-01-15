local vim = vim

-- TODO, on tmux osc52 paste doesn't work as expected, requires `tmux refresh-client -l` every time.
-- 1. Ditch tmux and use OSC52 for all
--    - osc52 has size limit, not fast enough 
-- 2. Hook every entrypoint (e.g. refresh-client -l before launching vim ... )

-- vim.g.clipboard = {
-- 	name = "OSC 52",
-- 	copy = {
-- 		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
-- 		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
-- 	},
-- 	paste = {
-- 		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
-- 		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
-- 	},
-- }

if vim.loop.os_uname().sysname == "Darwin" then
    vim.opt.clipboard = { "unnamed" }
else
    vim.opt.clipboard = { "unnamed", "unnamedplus" }
end

