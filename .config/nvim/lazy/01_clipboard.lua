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

local function paste()
	return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end

if vim.env.SSH_TTY ~= nil then
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = { ["+"] = paste, ["*"] = paste },
	}
	if vim.env.TMUX ~= nil then
		local copy = { "tmux", "load-buffer", "-w", "-" }
		local paste = { "tmux", "save-buffer", "-" }
		-- local paste = { "bash", "-c", "tmux refresh-client -l && sleep 0.05 && tmux save-buffer -" }
		vim.g.clipboard = {
			name = "tmux",
			copy = {
				["+"] = copy,
				["*"] = copy,
			},
			paste = {
				["+"] = paste,
				["*"] = paste,
			},
			cache_enabled = 0,
		}
	end

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
	--   name = "OSC 52",
	--   copy = {
	--     ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
	--     ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	--   },
	--   paste = {
	--     ["+"] = paste,
	--     ["*"] = paste,
	--   },
	-- }
else
	if vim.loop.os_uname().sysname == "Darwin" then
		vim.opt.clipboard = { "unnamed" }
	else
		vim.opt.clipboard = { "unnamed", "unnamedplus" }
	end

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
end
