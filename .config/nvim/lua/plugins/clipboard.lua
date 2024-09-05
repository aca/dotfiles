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

-- vim.g.clipboard = {
-- 	name = "custom clipboard",
-- 	copy = {
-- 		["+"] = "ci",
-- 		["*"] = "ci",
-- 	},
-- 	paste = {
-- 		["+"] = "co",
-- 		["*"] = "co",
-- 	},
-- 	cache_enabled = 1,
-- }
-- vim.g.clipboard.cache_enabled = 1

if vim.loop.os_uname().sysname == "Darwin" then
	vim.opt.clipboard = { "unnamed" }
else
	vim.opt.clipboard = { "unnamed", "unnamedplus" }
end

-- if vim.env.SSH_TTY ~= nil and vim.fn.hostname() == "rok-txxx-nix" then
-- 	vim.g.clipboard = {
-- 		name = "OSC 52",
-- 		copy = {
-- 			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
-- 			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
-- 		},
-- 		paste = {
-- 			["+"] = "pbpaste",
-- 			["*"] = "pbpaste",
-- 			-- ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
-- 			-- ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
-- 		},
-- 	}
-- end

-- if vim.env.SSH_TTY ~= nil then
-- 	vim.g.clipboard = {
-- 		name = "OSC 52",
-- 		copy = {
-- 			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
-- 			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
-- 		},
-- 		paste = {
-- 			["+"] = require("vim.ui.clipboard.osc52").paste("+"),
-- 			["*"] = require("vim.ui.clipboard.osc52").paste("*"),
-- 		},
-- 	}
-- end
