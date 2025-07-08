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

if vim.fn.executable("mac") then
    print("clipboard set to orbstack")
	vim.g.clipboard = {
		name = "macOS-clipboard",

		-- When you use the "+y or "*y commands in Neovim, it will copy the selected text to the clipboard using mac pbcopy .
		copy = {
			["+"] = "mac pbcopy", -- You can use `mac link pbcopy` first, then just use pbcopy
			["*"] = "mac pbcopy",
		},

		-- When you use the "+p or "*p commands in Neovim, it will paste the clipboard content by invoking mac pbpaste.
		paste = {
			["+"] = "mac pbpaste",
			["*"] = "mac pbpaste",
		},
		cache_enabled = 0,
	}

	-- This option tells Neovim to use the + register whenever you perform actions like copying and pasting.
	-- It essentially makes "+y and "+p the default behavior, even without explicitly specifying the register.
	-- So, y (yank) and p (put) will copy and paste directly to/from + register without requiring special register commands.
	vim.opt.clipboard = "unnamedplus"
end

if vim.fn.executable("mac2") then
    print("clipboard set to orbstack2")
	vim.g.clipboard = {
		name = "macOS-clipboard",

		-- When you use the "+y or "*y commands in Neovim, it will copy the selected text to the clipboard using mac pbcopy .
		copy = {
			["+"] = "mac pbcopy", -- You can use `mac link pbcopy` first, then just use pbcopy
			["*"] = "mac pbcopy",
		},

		-- When you use the "+p or "*p commands in Neovim, it will paste the clipboard content by invoking mac pbpaste.
		paste = {
			["+"] = "mac pbpaste",
			["*"] = "mac pbpaste",
		},
		cache_enabled = 0,
	}

	-- This option tells Neovim to use the + register whenever you perform actions like copying and pasting.
	-- It essentially makes "+y and "+p the default behavior, even without explicitly specifying the register.
	-- So, y (yank) and p (put) will copy and paste directly to/from + register without requiring special register commands.
	vim.opt.clipboard = "unnamedplus"
end
