local vim = vim
local g = vim.g
local opt = vim.opt
local o = vim.o

-- sidebar
-- o.signcolumn = "no"

-- if vim.env.VIM_NONU == "1" then
--     o.number = false
--     o.relativenumber = false
-- end

o.number = false
o.relativenumber = false
o.splitkeep = "screen"
-- o.signcolumn = "yes:1"
o.signcolumn = "no"
-- o.formatoptions = "jncroql"
o.formatoptions = "jnql"
o.fillchars = "eob: ,fold: ,foldclose:▸,foldopen:▾,stl: "

-- https://github.com/neovim/neovim/pull/25872
--
-- vim.defer_fn(function()
--     if vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
--       vim.g.clipboard = {
--         copy = {
--           ["+"] = "win32yank.exe -i --crlf",
--           ["*"] = "win32yank.exe -i --crlf",
--         },
--         paste = {
--           ["+"] = "win32yank.exe -o --lf",
--           ["*"] = "win32yank.exe -o --lf",
--         },
--       }
--     elseif vim.fn.has("unix") == 1 then
--       if vim.fn.executable("xclip") == 1 then
--         vim.g.clipboard = {
--           copy = {
--             ["+"] = "xclip -selection clipboard",
--             ["*"] = "xclip -selection clipboard",
--           },
--           paste = {
--             ["+"] = "xclip -selection clipboard -o",
--             ["*"] = "xclip -selection clipboard -o",
--           },
--         }
--       elseif vim.fn.executable("xsel") == 1 then
--         vim.g.clipboard = {
--           copy = {
--             ["+"] = "xsel --clipboard --input",
--             ["*"] = "xsel --clipboard --input",
--           },
--           paste = {
--             ["+"] = "xsel --clipboard --output",
--             ["*"] = "xsel --clipboard --output",
--           },
--         }
--       end
--       elseif vim.fn.executable("wl-paste") == 1 then
--         vim.g.clipboard = {
--           copy = {
--             ["+"] = "wl-copy",
--             ["*"] = "wl-copy",
--           },
--           paste = {
--             ["+"] = "wl-paste",
--             ["*"] = "wl-paste",
--           },
--         }
--       end
--     vim.opt.clipboard = "unnamedplus"
-- end, 80)

-- vim.cmd.packadd("nvim-osc52")
-- require("osc52").setup({
-- 	max_length = 0,
-- 	silent = true,
-- 	trim = false,
-- 	tmux_passthrough = true,
-- })
--
-- local function copy(lines, _)
-- 	require("osc52").copy(table.concat(lines, "\n"))
-- end
--
-- local function paste()
-- 	return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
-- end
--
-- vim.g.clipboard = {
-- 	name = "osc52",
-- 	copy = { ["+"] = copy, ["*"] = copy },
-- 	-- paste = { ["+"] = paste, ["*"] = paste },
-- 	-- paste = { ["+"] = paste, ["*"] = paste },
-- 	paste = {
-- 		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
-- 		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
-- 	},
-- }

-- if vim.env.VIM_OSC52_ENABLE ~= "0" then
--     vim.g.clipboard = {
--       name = 'OSC 52',
--       copy = {
--         ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--         ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--       },
--       paste = {
--         ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--         ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--       },
--     }
-- end

-- -- https://rumpelsepp.org/blog/nvim-clipboard-through-ssh/
-- vim.g.clipboard = {
--     name = 'tmux',
--     copy = {
--         ["+"] = {'tmux', 'load-buffer', '-w', '-'},
--         ["*"] = {'tmux', 'load-buffer', '-w', '-'},
--     },
--     paste = {
--         ["+"] = {'bash', '-c', 'tmux refresh-client -l && sleep 0.2 && tmux save-buffer -'},
--         ["*"] = {'bash', '-c', 'tmux refresh-client -l && sleep 0.2 && tmux save-buffer -'},
--     },
--     cache_enabled = false,
-- }

-- opt.clipboard = { "unnamed", "unnamedplus" }

-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = function()
--         print("called + ")
--         require('vim.ui.clipboard.osc52').copy('+')
--     end
--     ,
--     ['*'] = function()
--         print("called * ")
--         require('vim.ui.clipboard.osc52').copy('*')
--     end
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--   },
-- }

-- o.fencs = "euc-kr"
-- o.fencs = "ucs-bom,utf-8,default,latin1"
-- vim.o.fencs="ucs-bom,utf-8,cp949,euc-kr,default,latin1"

vim.o.cmdheight = 0
vim.o.laststatus = 3

-- o. = "%= %m%r%h%w %l:%c %P "
-- o.statusline = "%= %m%r%h%w %l:%c %P "

-- _G.wordcount__visual_words = function()
--     local wordcount = vim.fn.wordcount()["visual_bytes"]
--     if wordcount == nil then
--         return ""
--     else
--         return wordcount
--     end
-- end
-- o.statusline = "%{%v:lua.wordcount__visual_words()%}%=%l/%L"
o.statusline = "%=%l/%L"

o.tabline = " %t"
o.showtabline = 2
-- vim.o.statusline = "%t"
-- opt.winbar = "%=%l:%c %P %m%f"
-- opt.winbar = " "

o.mmp = 50000
o.shell = "/bin/sh"
opt.wildignore = { "/tmp/*", "*.so", "*.swp", "*.zip", "*.pyc", "*.db", "*.sqlite", "*.git/*" }
-- o.conceallevel = 3
o.conceallevel = 2
o.shortmess = "aItcF"
opt.clipboard = { "unnamed", "unnamedplus" }
opt.nrformats = { "bin", "hex", "alpha", "octal" }

opt.isfname = opt.isfname - "=" -- fix gf for file_path=path/to/file.txt
opt.termguicolors = true

opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal", "vertical" }
opt.completeopt = { "menu", "menuone", "noselect" }

opt.wrapmargin = 0
opt.lazyredraw = false -- noice.nvim

opt.cursorcolumn = false
opt.cursorline = true
-- opt.timeoutlen = 500

-- fold
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 7

opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.updatetime = 500 -- Make updates happen faster
opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor

opt.inccommand = "split"
opt.swapfile = false
opt.shada = { "!", "'1000", "<50", "s10", "h" }
opt.hidden = true -- zepl.vim

opt.joinspaces = false
opt.belloff = "all"

-- Tabs
-- opt.autoindent = true
-- opt.cindent = true

opt.indentkeys = opt.indentkeys + "!^Y"
opt.cinkeys = opt.cinkeys - "0#" -- https://vim.fandom.com/wiki/Restoring_indent_after_typing_hash
opt.wrap = false
opt.wrapscan = false

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.incsearch = true -- Makes search act like search in modern browsers
opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom

opt.modelineexpr = true
opt.showcmd = false
opt.showmode = false

-- opt.wildmenu = true
-- opt.wildmode = "longest:full"
-- opt.wildoptions = "pum"
-- Cool floating window popup menu for completion on command line
opt.pumblend = 17

g.mapleader = " "
g.maplocalleader = " "

-- disable default vim stuffs for faster startuptime
g.loaded_2html_plugin = 1
g.loaded_syntax = 1
g.loaded_clipboard_provider = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logiPat = 1
g.loaded_remote_plugins = 1
g.loaded_rrhelper = 1
g.loaded_spellfile_plugin = 1
g.loaded_tarPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_zipPlugin = 1
g.loaded_ftplugin = 1
g.loaded_netrwPlugin = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
