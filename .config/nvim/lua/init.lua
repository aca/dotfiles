local function settings()
    local g = vim.g
    local opt = vim.opt
    opt.cmdheight = 1
    opt.laststatus = 0

    opt.statusline = "%= %m%r%h%w %l:%c %P "
    -- o.winbar = "%=%l:%c %P %m%f"

    opt.mmp = 5000
    opt.shell = "/bin/sh"
    opt.wildignore = { "/tmp/*", "*.so", "*.swp", "*.zip", "*.pyc", "*.db", "*.sqlite", "*.git/*" }
    opt.conceallevel = 2
    opt.shortmess = "aItcF"
    opt.clipboard = { "unnamed", "unnamedplus" }
    -- o.virtualedit = "block"
    opt.nrformats = { "bin", "hex", "alpha", "octal" }
    opt.signcolumn = "no"

    opt.isfname = opt.isfname - "=" -- fix gf for file_path=path/to/file.txt
    opt.termguicolors = true

    opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }
    opt.completeopt = { "menu", "menuone", "noselect" }

    opt.fillchars = opt.fillchars
        + {
            eob = " ",
            foldclose = "▸",
            foldopen = "▾",
            fold = " ",
            stl = " ",
            -- vert =  " ",
        }

    opt.wrapmargin = 0
    opt.lazyredraw = true

    opt.cursorcolumn = false
    opt.cursorline = true
    opt.timeoutlen = 500

    -- fold
    -- opt.foldmethod="syntax"
    opt.foldlevel = 99
    opt.foldlevelstart = 99
    opt.foldnestmax = 2

    opt.ignorecase = true -- Ignore case when searching...
    opt.smartcase = true -- ... unless there is a capital letter in the query
    opt.showmatch = true -- show matching brackets when text indicator is over them
    opt.updatetime = 1000 -- Make updates happen faster
    opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
    opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor

    opt.formatoptions = opt.formatoptions
        - "a" -- Auto formatting is BAD.
        - "t" -- Don't auto format my code. I got linters for that.
        + "c" -- In general, I like it when comments respect textwidth
        + "q" -- Allow formatting comments w/ gq
        -- - "o" -- O and o, don't continue comments
        -- + "r" -- But do continue when pressing enter.
        + "n" -- Indent past the formatlistpat, not underneath it.
        + "j" -- Auto-remove comments if possible.
        - "2" -- I'm not in gradeschool anymore

    opt.inccommand = "split"
    opt.swapfile = false
    opt.shada = { "!", "'1000", "<50", "s10", "h" }
    opt.hidden = true -- zepl.vim

    opt.joinspaces = false
    opt.belloff = "all" -- Just turn the dang bell off

    opt.number = false
    opt.relativenumber = false

    -- Tabs
    opt.autoindent = true
    opt.cindent = true
    -- https://vim.fandom.com/wiki/Restoring_indent_after_typing_hash
    opt.cinkeys = opt.cinkeys - "0#"
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

    -- opt.wildmode = opt.wildmode - "list"
    -- opt.wildmode = opt.wildmode + { "longest", "full" }

    -- opt.list = true
    -- opt.listchars:append("space:⋅")
    -- opt.listchars:append("eol:↴")

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
end

local function filetype()
    -- https://neovim.discourse.group/t/introducing-filetype-lua-and-a-call-for-help/1806#how-do-i-use-it-2
    --
    -- vim.filetype.add({
    --     pattern = {
    --         [".*"] = function(path, bufnr)
    --             local firstline = vim.api.nvim_buf_get_lines(bufnr, 0, 1, 0)[1]
    --             if firstline:match("#!/usr/bin/env") then
    --                 local v, _ = string.gsub(firstline, "#!/usr/bin/env ", "")
    --                 return v
    --             end
    --         end,
    --     },
    -- })
end

local function utils()
    function _G.P(...)
        vim.pretty_print(...)
    end
end

local function colors_seoul256()
    local nvim_set_hl = vim.api.nvim_set_hl
    nvim_set_hl(0, "Normal", { background = 0, foreground = 14277081 })
    nvim_set_hl(0, "SyntaxError", { special = 16145237, undercurl = true })
    nvim_set_hl(0, "SyntaxWarning", { special = 14985831, undercurl = true })
    nvim_set_hl(0, "SyntaxInfo", { special = 7712471, undercurl = true })
    nvim_set_hl(0, "SyntaxHint", { special = 10929543, undercurl = true })
    nvim_set_hl(0, "Comment", { foreground = 7444594 })
    nvim_set_hl(0, "ColorColumn", { background = 394758 })
    nvim_set_hl(0, "Conceal", { background = 394758, foreground = 15329769 })
    nvim_set_hl(0, "Cursor", { background = 14277081, foreground = 1513239 })
    nvim_set_hl(0, "CursorI", {})
    nvim_set_hl(0, "CursorR", {})
    nvim_set_hl(0, "CursorO", {})
    nvim_set_hl(0, "CursorLine", { background = 394758 })
    nvim_set_hl(0, "Directory", {})
    nvim_set_hl(0, "DiffAdd", { background = 28416 })
    nvim_set_hl(0, "DiffChange", { background = 4144959 })
    nvim_set_hl(0, "DiffDelete", { background = 10122098, bold = true })
    nvim_set_hl(0, "DiffText", { background = 7539456, bold = true })
    nvim_set_hl(0, "EndOfBuffer", { bold = true, foreground = 7500402 })
    nvim_set_hl(0, "Error", { foreground = 16145237 })
    nvim_set_hl(0, "ErrorMsg", { background = 16145237, foreground = 0 })
    nvim_set_hl(0, "VertSplit", {})
    -- nvim_set_hl(0,  "Folded", {   background = 2434341,   foreground = 10066034 } )
    -- nvim_set_hl(0,  "FoldColumn", {   background = 2434341,   foreground = 12434584 } )
    nvim_set_hl(0, "Folded", { background = "#050505", foreground = "#ffffff", italic = true })
    nvim_set_hl(0, "FoldColumn", {})
    nvim_set_hl(0, "SignColumn", { background = 0, foreground = 14277081 })

    nvim_set_hl(0, "IncSearch", { background = 7712471, foreground = 0 })
    nvim_set_hl(0, "Substitute", { background = 14985831, foreground = 0 })
    nvim_set_hl(0, "LineNr", { background = 2434341, foreground = 10066034 })
    nvim_set_hl(0, "CursorLineNr", { background = 394758, bold = true, foreground = 12481906 })
    nvim_set_hl(0, "MatchParen", { background = 4457988, bold = true, foreground = 16145237, italic = true })
    nvim_set_hl(0, "ParenMatch", { background = 4457988, bold = true, foreground = 16145237, italic = true })
    nvim_set_hl(0, "ModeMsg", {})
    nvim_set_hl(0, "MsgArea", {})
    nvim_set_hl(0, "MsgSeparator", {})
    nvim_set_hl(0, "MoreMsg", { bold = true, foreground = 7712471 })
    nvim_set_hl(0, "NonText", { bold = true, foreground = 7500402 })
    nvim_set_hl(0, "NormalFloat", { background = 394758 })
    nvim_set_hl(0, "NormalNC", {})
    nvim_set_hl(0, "Pmenu", { background = 3551792, foreground = 12762812 })
    nvim_set_hl(0, "PmenuSel", { background = 16777215, foreground = 0 })
    nvim_set_hl(0, "PmenuSbar", { background = 3551792 })
    nvim_set_hl(0, "PmenuThumb", { background = 9603463 })
    nvim_set_hl(0, "Question", {})
    nvim_set_hl(0, "QuickFixLine", { background = 14985831, foreground = 0 })
    nvim_set_hl(0, "Search", { background = 14985831, foreground = 0 })
    nvim_set_hl(0, "SpecialKey", { bold = true })
    nvim_set_hl(0, "SpellBad", { special = 16145237, undercurl = true })
    nvim_set_hl(0, "SpellCap", { special = 7712471, undercurl = true })
    nvim_set_hl(0, "SpellLocal", { special = 10929543, undercurl = true })
    nvim_set_hl(0, "SpellRare", { special = 14985831, undercurl = true })
    -- nvim_set_hl(0,  "StatusLine", {   background = 14671549,   bold = true,   foreground = 10122098,   reverse = true } )
    -- nvim_set_hl(0,  "StatusLineNC", {   background = 14671549,   foreground = 3355187,   reverse = true } )
    nvim_set_hl(0, "StatusLine", { background = "#141414", foreground = "#4c5265", italic = true })
    nvim_set_hl(0, "StatusLineNC", { background = "#141414", foreground = "#4c5265", italic = true })

    -- nvim_set_hl(0, "TabLine", { background = 4934475, underline = true })
    -- nvim_set_hl(0, "TabLineFill", { foreground = 3355187, reverse = true })
    -- nvim_set_hl(0, "TabLineSel", { background = 29043, bold = true, foreground = 14671549 })
    nvim_set_hl(0, "TabLine", { foreground = 9603463 })
    nvim_set_hl(0, "TabLineFill", { foreground = 9603463 })
    nvim_set_hl(0, "TabLineSel", { bold = true, foreground = 12762812 })

    nvim_set_hl(0, "Title", { bold = true, foreground = 14728892 })
    nvim_set_hl(0, "Visual", { background = 29043 })
    nvim_set_hl(0, "VisualNOS", {})
    nvim_set_hl(0, "Warning", { foreground = 14985831 })
    nvim_set_hl(0, "WarningMsg", { foreground = 14985831 })
    nvim_set_hl(0, "Whitespace", { bold = true, foreground = 7500402 })
    nvim_set_hl(0, "WildMenu", { foreground = 16777215 })
    nvim_set_hl(0, "Constant", { foreground = 7322813 })
    nvim_set_hl(0, "String", { foreground = 10009789 })
    nvim_set_hl(0, "Character", { foreground = 14719897 })
    nvim_set_hl(0, "Number", { foreground = 16768665 })
    nvim_set_hl(0, "Boolean", { foreground = 10066621 })
    nvim_set_hl(0, "Float", { foreground = 16768665 })
    nvim_set_hl(0, "Identifier", { foreground = 16760765 })
    nvim_set_hl(0, "Function", { foreground = 14671549 })
    nvim_set_hl(0, "Statement", { bold = true, foreground = 10009753 })
    nvim_set_hl(0, "Conditional", { foreground = 10010334 })
    nvim_set_hl(0, "Repeat", { foreground = 7445727 })
    nvim_set_hl(0, "Label", { bold = true, foreground = 10009753 })
    nvim_set_hl(0, "Operator", { foreground = 14605721 })
    nvim_set_hl(0, "Keyword", { foreground = 14776473 })
    nvim_set_hl(0, "Exception", { foreground = 14755442 })
    nvim_set_hl(0, "PreProc", { foreground = 12434290 })
    nvim_set_hl(0, "Include", { foreground = 14784882 })
    nvim_set_hl(0, "Define", { foreground = 14784882 })
    nvim_set_hl(0, "Macro", { foreground = 14784882 })
    nvim_set_hl(0, "PreCondit", { foreground = 14784882 })
    nvim_set_hl(0, "Type", { bold = true, foreground = 14662770 })
    nvim_set_hl(0, "StorageClass", { bold = true, foreground = 14662770 })
    nvim_set_hl(0, "Structure", { foreground = 9952735 })
    nvim_set_hl(0, "Typedef", { bold = true, foreground = 14662770 })
    nvim_set_hl(0, "Special", { foreground = 16760216 })
    nvim_set_hl(0, "SpecialChar", {})
    nvim_set_hl(0, "Tag", { foreground = 16760216 })
    nvim_set_hl(0, "Delimiter", { foreground = 12490867 })
    nvim_set_hl(0, "SpecialComment", {})
    nvim_set_hl(0, "Debug", { foreground = 16760216 })
    nvim_set_hl(0, "Underlined", { foreground = 14728892, underline = true })
    nvim_set_hl(0, "Bold", {})
    nvim_set_hl(0, "Italic", {})
    nvim_set_hl(0, "Todo", { foreground = 14755442 })
    nvim_set_hl(0, "LspReferenceText", { special = 7712471, underline = true })
    nvim_set_hl(0, "LspReferenceRead", { special = 16777215, underline = true })
    nvim_set_hl(0, "LspReferenceWrite", { special = 10929543, underline = true })
    nvim_set_hl(0, "IndentBlanklineChar", { foreground = 3551792 })
    nvim_set_hl(0, "IndentBlanklineContextChar", { foreground = 11293568 })
    nvim_set_hl(0, "DiagnosticError", { foreground = 16711680 })
    nvim_set_hl(0, "DiagnosticWarn", { foreground = 14985831 })
    nvim_set_hl(0, "DiagnosticInfo", { foreground = 7712471 })
    nvim_set_hl(0, "DiagnosticHint", { foreground = 10929543 })
    nvim_set_hl(0, "DiagnosticUnderlineError", { special = 16145237, undercurl = true })
    nvim_set_hl(0, "DiagnosticUnderlineWarn", { special = 14985831, undercurl = true })
    nvim_set_hl(0, "DiagnosticUnderlineInfo", { special = 7712471, undercurl = true })
    nvim_set_hl(0, "DiagnosticUnderlineHint", { special = 10929543, undercurl = true })
    nvim_set_hl(0, "DiagnosticSignError", { foreground = 16145237 })
    nvim_set_hl(0, "DiagnosticSignWarning", { foreground = 14985831 })
    nvim_set_hl(0, "DiagnosticSignInformation", { foreground = 7712471 })
    nvim_set_hl(0, "DiagnosticSignHint", { foreground = 10929543 })
    nvim_set_hl(0, "TSConstant", { foreground = 7322813 })
    nvim_set_hl(0, "TSProperty", { foreground = 16760765 })
    nvim_set_hl(0, "TSStringRegex", { foreground = 10009789 })
    nvim_set_hl(0, "TSStringEscape", {})

    -- gitsigns.nvim
    vim.defer_fn(function()
        nvim_set_hl(0, "GitSignsAdd", { bg = "NONE", fg = "green" })
        nvim_set_hl(0, "GitSignsChange", { bg = "NONE", fg = "blue" })
        nvim_set_hl(0, "GitSignsDelete", { bg = "NONE", fg = "red" })
        nvim_set_hl(0, "GitSignsChange", { bg = "NONE", fg = "yellow" })
    end, 100)
end

local function colors_monotone()
    -- local nvim_set_hl = vim.api.nvim_set_hl
    -- nvim_set_hl(0, "TelescopeNormal", { bg = "#1c1c1e" })
    -- nvim_set_hl(0, "Normal", {})
    -- nvim_set_hl(0, "Comment", { foreground = 6708828, italic = true })
    -- nvim_set_hl(0, "ColorColumn", { background = 6708828 })
    -- nvim_set_hl(0, "Conceal", {})
    -- nvim_set_hl(0, "Cursor", { background = 16145237 })
    -- nvim_set_hl(0, "CursorI", { background = 16145237 })
    -- nvim_set_hl(0, "CursorR", { background = 14985831 })
    -- nvim_set_hl(0, "CursorO", { background = 7712471 })
    -- nvim_set_hl(0, "CursorLine", { background = 855052 })
    -- nvim_set_hl(0, "DiffAdd", { foreground = 10929543 })
    -- nvim_set_hl(0, "DiffChange", { foreground = 14985831 })
    -- nvim_set_hl(0, "DiffDelete", { foreground = 16145237 })
    -- nvim_set_hl(0, "DiffText", { background = 16145237, foreground = 0 })
    -- nvim_set_hl(0, "EndOfBuffer", { foreground = 6579380 })
    -- nvim_set_hl(0, "VertSplit", { foreground = 6708828 })
    -- nvim_set_hl(0, "Folded", { background = 2630948, foreground = 9603463, italic = true })
    -- nvim_set_hl(0, "FoldColumn", {})
    -- nvim_set_hl(0, "SignColumn", {})
    -- nvim_set_hl(0, "LineNr", { foreground = "#333333" })
    -- nvim_set_hl(0, "CursorLineNr", { foreground = "#606060" })
    -- nvim_set_hl(0, "NonText", { foreground = 11293568 })
    -- nvim_set_hl(0, "NormalFloat", { background = 2630948, foreground = 10393236 })
    -- nvim_set_hl(0, "NormalNC", {})
    -- nvim_set_hl(0, "QuickFixLine", {})
    -- nvim_set_hl(0, "StatusLine", { background = "#141414", foreground = "#4c5265", italic = true })
    -- nvim_set_hl(0, "StatusLineNC", { background = "#141414", foreground = "#4c5265", italic = true })
    -- nvim_set_hl(0, "WinBar", { background = "#141414", foreground = "#4c5265", italic = true })
    -- nvim_set_hl(0, "WinBarNC", { background = "#141414", foreground = "#4c5265", italic = true })
    -- nvim_set_hl(0, "TabLine", { foreground = 9603463 })
    -- nvim_set_hl(0, "TabLineFill", { foreground = 9603463 })
    -- nvim_set_hl(0, "TabLineSel", { bold = true, foreground = 12762812 })
    -- nvim_set_hl(0, "Title", { bold = true })
    -- nvim_set_hl(0, "Visual", { background = 16777215, foreground = 0 })
    -- nvim_set_hl(0, "Whitespace", { foreground = 4933188 })
    -- nvim_set_hl(0, "Constant", { special = 16777215 })
    -- nvim_set_hl(0, "String", { foreground = 10393236 })
    -- nvim_set_hl(0, "Boolean", { italic = true })
    -- nvim_set_hl(0, "Identifier", { italic = true })
    -- nvim_set_hl(0, "Function", { bold = true })
    -- nvim_set_hl(0, "Statement", { bold = true, italic = true })
    -- nvim_set_hl(0, "Include", { italic = true })
    -- nvim_set_hl(0, "Type", { bold = true })
    -- nvim_set_hl(0, "StorageClass", {})
    -- nvim_set_hl(0, "Structure", {})
    -- nvim_set_hl(0, "Delimiter", { foreground = 12762812 })
    -- nvim_set_hl(0, "Underlined", { underline = true })
    -- nvim_set_hl(0, "Bold", { bold = true })
    -- nvim_set_hl(0, "Italic", { italic = true })
    -- nvim_set_hl(0, "Todo", { bold = true, foreground = 14985831, italic = true })
    --
    -- nvim_set_hl(0, "TSConstant", { special = 16777215, underline = true })
    -- nvim_set_hl(0, "TSProperty", { italic = true })
    -- nvim_set_hl(0, "TSStringRegex", { foreground = 12762812, italic = true })
    -- nvim_set_hl(0, "TSStringEscape", { bold = true, foreground = 16777215 })
    -- nvim_set_hl(0, "Typedef", {})
    -- nvim_set_hl(0, "Special", {})
    --
    -- nvim_set_hl(0, "Character", {})
    -- nvim_set_hl(0, "Number", {})
    -- nvim_set_hl(0, "Float", {})
    --
    -- nvim_set_hl(0, "Conditional", {})
    -- nvim_set_hl(0, "Repeat", {})
    -- nvim_set_hl(0, "Label", {})
    -- nvim_set_hl(0, "Operator", {})
    -- nvim_set_hl(0, "Keyword", {})
    -- nvim_set_hl(0, "Exception", {})
    -- nvim_set_hl(0, "PreProc", {})
    -- nvim_set_hl(0, "Define", {})
    -- nvim_set_hl(0, "Macro", {})
    -- nvim_set_hl(0, "PreCondit", {})
    -- nvim_set_hl(0, "Tag", {})
    -- nvim_set_hl(0, "Debug", {})
    --
    -- vim.defer_fn(function()
    --     nvim_set_hl(0, "ModeMsg", {})
    --     nvim_set_hl(0, "MsgArea", {})
    --     nvim_set_hl(0, "MsgSeparator", {})
    --     nvim_set_hl(0, "SpecialChar", {})
    --
    --     nvim_set_hl(0, "Search", { background = 14985831, foreground = 0 })
    --     nvim_set_hl(0, "Question", {})
    --     nvim_set_hl(0, "Substitute", { background = 14985831, foreground = 0 })
    --     nvim_set_hl(0, "MoreMsg", { bold = true, foreground = 7712471 })
    --     nvim_set_hl(0, "WildMenu", { foreground = 16777215 })
    --     nvim_set_hl(0, "VisualNOS", {})
    --     nvim_set_hl(0, "SpecialKey", { bold = true })
    --
    --     -- gitsigns.nvim
    --     nvim_set_hl(0, "GitSignsAdd", { bg = "NONE", fg = "green" })
    --     nvim_set_hl(0, "GitSignsChange", { bg = "NONE", fg = "blue" })
    --     nvim_set_hl(0, "GitSignsDelete", { bg = "NONE", fg = "red" })
    --     nvim_set_hl(0, "GitSignsChange", { bg = "NONE", fg = "yellow" })
    --
    --     -- nvim-cmp
    --     -- nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
    --     -- nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
    --     -- nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { bg = "NONE", fg = "#569CD6" })
    --     -- nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
    --     -- nvim_set_hl(0, "CmpItemKindInterface", { bg = "NONE", fg = "#9CDCFE" })
    --     -- nvim_set_hl(0, "CmpItemKindText", { bg = "NONE", fg = "#9CDCFE" })
    --     -- nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
    --     -- nvim_set_hl(0, "CmpItemKindMethod", { bg = "NONE", fg = "#C586C0" })
    --     -- nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
    --     -- nvim_set_hl(0, "CmpItemKindProperty", { bg = "NONE", fg = "#D4D4D4" })
    --     -- nvim_set_hl(0, "CmpItemKindUnit", { bg = "NONE", fg = "#D4D4D4" })
    --     nvim_set_hl(0, "SpecialComment", {})
    --     nvim_set_hl(0, "IncSearch", { background = 7712471, foreground = 0 })
    --     -- nvim_set_hl(0, "CurSearch", { background = "red", foreground = 0 })
    --
    --     nvim_set_hl(0, "Error", { bold = false, foreground = 16145237 })
    --     nvim_set_hl(0, "ErrorMsg", { background = 16145237, bold = false, foreground = 0 })
    --     nvim_set_hl(0, "Warning", { bold = false, foreground = 14985831 })
    --     nvim_set_hl(0, "WarningMsg", { bold = false, foreground = 14985831 })
    --
    --     nvim_set_hl(0, "SpellBad", { special = 16145237, undercurl = true })
    --     nvim_set_hl(0, "SpellCap", { special = 7712471, undercurl = true })
    --     nvim_set_hl(0, "SpellLocal", { special = 10929543, undercurl = true })
    --     nvim_set_hl(0, "SpellRare", { special = 14985831, undercurl = true })
    --
    --     nvim_set_hl(0, "SyntaxError", { special = 16145237, undercurl = true })
    --     nvim_set_hl(0, "SyntaxWarning", { special = 14985831, undercurl = true })
    --     nvim_set_hl(0, "SyntaxInfo", { special = 7712471, undercurl = true })
    --     nvim_set_hl(0, "SyntaxHint", { special = 10929543, undercurl = true })
    --
    --     nvim_set_hl(0, "Pmenu", { background = 3551792, foreground = 12762812 })
    --     nvim_set_hl(0, "PmenuSel", { background = 16777215, foreground = 0 })
    --     nvim_set_hl(0, "PmenuSbar", { background = 3551792 })
    --     nvim_set_hl(0, "PmenuThumb", { background = 9603463 })
    --
    --     nvim_set_hl(0, "MatchParen", { background = 4457988, bold = true, foreground = 16145237, italic = true })
    --     nvim_set_hl(0, "ParenMatch", { background = 4457988, bold = true, foreground = 16145237, italic = true })
    --     nvim_set_hl(0, "Directory", {})
    --
    --     nvim_set_hl(0, "LspReferenceText", { special = 7712471, underline = true })
    --     nvim_set_hl(0, "LspReferenceRead", { special = 16777215, underline = true })
    --     nvim_set_hl(0, "LspReferenceWrite", { special = 10929543, underline = true })
    --     nvim_set_hl(0, "IndentBlanklineChar", { foreground = 3551792 })
    --     nvim_set_hl(0, "IndentBlanklineContextChar", { foreground = 11293568 })
    --     -- nvim_set_hl(0, "DiagnosticError", { background = 4457988, foreground = 16145237 })
    --     nvim_set_hl(0, "DiagnosticWarn", { background = 4007179, foreground = 14985831 })
    --     nvim_set_hl(0, "DiagnosticInfo", { background = 1058615, foreground = 7712471 })
    --     nvim_set_hl(0, "DiagnosticHint", { background = 2371607, foreground = 10929543 })
    --     nvim_set_hl(0, "DiagnosticUnderlineError", { special = 16145237, undercurl = true })
    --     nvim_set_hl(0, "DiagnosticUnderlineWarn", { special = 14985831, undercurl = true })
    --     nvim_set_hl(0, "DiagnosticUnderlineInfo", { special = 7712471, undercurl = true })
    --     nvim_set_hl(0, "DiagnosticUnderlineHint", { special = 10929543, undercurl = true })
    --     nvim_set_hl(0, "DiagnosticSignError", { background = 3146755, foreground = 16145237 })
    --     nvim_set_hl(0, "DiagnosticSignWarning", { background = 2824968, foreground = 14985831 })
    --     nvim_set_hl(0, "DiagnosticSignInformation", { background = 728104, foreground = 7712471 })
    --     nvim_set_hl(0, "DiagnosticSignHint", { background = 1712657, foreground = 10929543 })
    --     nvim_set_hl(0, "DiagnosticVirtualTextError", { italic = true, fg = "#65737e" })
    --     nvim_set_hl(0, "DiagnosticVirtualTextWarn", { italic = true, fg = "#65737e" })
    --     nvim_set_hl(0, "DiagnosticVirtualTextInfo", { italic = true, fg = "#65737e" })
    --     nvim_set_hl(0, "DiagnosticVirtualTextHint", { italic = true, fg = "#65737e" })
    -- end, 100)
end

local function autocmds()
    local group = vim.api.nvim_create_augroup("_init", { clear = true })
    local nvim_create_autocmd = vim.api.nvim_create_autocmd

    -- restore cursor position on start
    nvim_create_autocmd("BufReadPost", { command = [[ 
    silent! exe "normal! g`\"" 
]], group = group })

    -- templates, zk
    nvim_create_autocmd("BufNewFile", {
        group = group,
        pattern = { "**/src/zk/**.md" },
        command = [[
execute "0r! ~/.config/nvim/templates/zettels.sh" . ' ' . expand('%:t:r')
    ]],
    })

    -- templates, gh actions
    nvim_create_autocmd("BufNewFile", {
        group = group,
        pattern = { "**/.github/workflows/**.y*ml" },
        command = [[
execute "0r! ~/.config/nvim/templates/gh-actions.sh" . ' ' . expand('%:t:r')
    ]],
    })

    -- load dirvish on open if it's directory
    nvim_create_autocmd("BufEnter", {
        group = group,
        callback = function()
            -- if vim.fn.isdirectory(vim.fn.expand("%:p")) == 1 then
            if vim.fn.isdirectory(vim.api.nvim_buf_get_name(0)) == 1 then
                vim.cmd([[ 
      packadd vim-dirvish
      execute 'Dirvish %'
      ]])
            end
        end,
    })
end

local function lazy()
    require("impatient").enable_profile()
    -- require("impatient")

    vim.cmd([[
        packadd nvim-treesitter
        packadd nvim-treesitter-context
        packadd playground

        packadd nvim-lspconfig
        " let g:Illuminate_delay = 1
        "
        " packadd vim-illuminate
        packadd nvim-lsp-installer
    ]])

    require("core.treesitter")
    require("core.lsp")
    require("core.luasnip")
    require("core.cmp")
    require("core.keymap")

    vim.defer_fn(function() 
        require("core.lazy")
        -- require("core.zettels")

        vim.cmd([[
            runtime! lua/plugins/*
            runtime! lua/command/*
            runtime! lua/autocmd/*
        ]])

        vim.defer_fn(function()
            -- prevent delay on startup
            vim.cmd [[ silent! helptags ALL ]]
        end, 100)
    end, 50)
end

settings()
filetype()
utils()
colors_seoul256()
autocmds()
vim.defer_fn(lazy, 30)
