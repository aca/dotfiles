local opt = vim.opt
local o = vim.o

vim.opt.wrap = false
vim.opt.wrapscan = false
vim.opt.wrapmargin = 0

vim.o.splitkeep = "screen"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query
vim.opt.showmatch = true -- show matching brackets when text indicator is over them
vim.opt.updatetime = 500 -- Make updates happen faster
vim.opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
vim.opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor

-- opt.wildmenu = true
-- opt.wildmode = "longest:full"
-- opt.wildoptions = "pum"
-- Cool floating window popup menu for completion on command line
vim.opt.pumblend = 17

vim.opt.isfname = vim.opt.isfname - "=" -- fix gf for file_path=path/to/file.txt
vim.opt.termguicolors = true

vim.opt.nrformats = { "bin", "hex", "alpha", "octal" }


opt.indentkeys = opt.indentkeys + "!^Y"
opt.cinkeys = opt.cinkeys - "0#" -- https://vim.fandom.com/wiki/Restoring_indent_after_typing_hash

opt.incsearch = true -- Makes search act like search in modern browsers
opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom



opt.joinspaces = false
opt.belloff = "all"

vim.o.formatoptions = "jnql"
