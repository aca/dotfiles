local g = vim.g
local opt = vim.opt
local o = vim.o

opt.shell = "/bin/sh"
o.wildignore = "/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*.git/*"
o.conceallevel = 2
o.shortmess = "aItcF"
o.clipboard = "unnamed,unnamedplus"
opt.signcolumn = "yes"
o.virtualedit = "block"
o.nrformats = "bin,hex,alpha,octal"

opt.isfname = opt.isfname - "=" -- fix gf for file_path=path/to/file.txt

o.termguicolors = true

o.diffopt = "filler,vertical,internal,algorithm:histogram,context:1000000" -- https://jdhao.github.io/2021/10/24/diff_in_vim/
o.completeopt = "menu,menuone,noselect"

-- o.fillchars = "fold: ,vert:│,eob: ,msgsep:‾"
opt.fillchars = {
	eob = " ",
	-- vert =  " ",
}
o.wrapmargin = 0

o.lazyredraw = true

g.mapleader = " "
g.maplocalleader = " "

g.cursorcolumn = false
g.cursorline = true
g.timeoutlen = 400

-- fold
g.foldlevel = 99
g.foldlevelstart = 99
-- g.foldmethod = "marker"
g.foldcolumn = 0

opt.cursorline = true -- Highlight the current line
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.updatetime = 1000 -- Make updates happen faster
opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor
if g._minimal then
	opt.laststatus = 0
else
	opt.laststatus = 2
end

opt.formatoptions = opt.formatoptions
	- "a" -- Auto formatting is BAD.
	- "t" -- Don't auto format my code. I got linters for that.
	+ "c" -- In general, I like it when comments respect textwidth
	+ "q" -- Allow formatting comments w/ gq
	- "o" -- O and o, don't continue comments
	+ "r" -- But do continue when pressing enter.
	+ "n" -- Indent past the formatlistpat, not underneath it.
	+ "j" -- Auto-remove comments if possible.
	- "2" -- I'm not in gradeschool anymore

opt.inccommand = "split"
opt.swapfile = false -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }
opt.hidden = true -- zepl.vim

opt.joinspaces = false -- Two spaces and grade school, we're done
opt.belloff = "all" -- Just turn the dang bell off

if g._minimal then
	opt.number = false
else
	opt.number = true
end

-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = false
opt.wrapscan = false

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
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

-- opt.wildmode = opt.wildmode - "list"
-- opt.wildmode = opt.wildmode + { "longest", "full" }

-- disable default vim stuffs for faster startuptime
g.loaded_tutor_mode_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_tarPlugin = 1
g.loaded_remote_plugins = 1
g.loaded_gzip = 1
g.loaded_zipPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_shada_plugin = 1
g.loaded_spellfile_plugin = 1
g.loaded_remote_plugins = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1

g.loaded_matchit = 1

-- https://github.com/monkoose/matchparen.nvim
g.loaded_matchparen = 1

g.do_filetype_lua = 1
g.did_load_filetypes = 0

-- g.loaded_netrw = 1
-- g.loaded_netrwSettings = 1
-- g.loaded_netrwFileHandlers = 1
g.loaded_netrwPlugin = 1
