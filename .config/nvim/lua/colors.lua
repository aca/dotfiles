-- raider.vim

local nvim_set_hl = vim.api.nvim_set_hl
nvim_set_hl(0, "Normal", { fg = "#C9C9C9" })
nvim_set_hl(0, "NonText", { fg = "#4A4A4A" })
nvim_set_hl(0, "Comment", { fg = "#666967" })
nvim_set_hl(0, "Constant", { fg = "#88766F" })
nvim_set_hl(0, "String", { fg = "#94BACA" })
nvim_set_hl(0, "Identifier", { fg = "#96A8A1" })
nvim_set_hl(0, "Statement", { fg = "#998B70" })
nvim_set_hl(0, "Exception", { fg = "#A74F4F" })
nvim_set_hl(0, "Keyword", { fg = "#858CA6" })
nvim_set_hl(0, "Operator", { fg = "#C9C9C9" })
nvim_set_hl(0, "PreProc", { fg = "#88766F" })
nvim_set_hl(0, "Include", { fg = "#88766F" })
nvim_set_hl(0, "Macro", { fg = "#88766F" })
nvim_set_hl(0, "Define", { fg = "#998B70" })
nvim_set_hl(0, "Type", { fg = "#858CA6" })
nvim_set_hl(0, "Special", { fg = "#666967" })
nvim_set_hl(0, "Error", { bg = "NONE", fg = "#A74F4F", bold = true })
nvim_set_hl(0, "Warning", { bg = "NONE", fg = "#EAB56B", bold = true })
nvim_set_hl(0, "ModeMsg", { bg = "NONE", fg = "#94BACA" })
nvim_set_hl(0, "Todo", { bg = "NONE", fg = "#679D80", bold = true })
nvim_set_hl(0, "Underlined", { bg = "NONE", fg = "#C9C9C9", underline = true })
nvim_set_hl(0, "StatusLine", { bg = "#000000", fg = "#998B70", italic = false })
nvim_set_hl(0, "StatusLineNC", { bg = "#000000", fg = "#666967", italic = false })
nvim_set_hl(0, "Title", { bg = "NONE", fg = "#998B70", bold = true })
nvim_set_hl(0, "LineNr", { bg = "NONE", fg = "#666967" })
nvim_set_hl(0, "CursorLineNr", { bg = "#2A2A2A", fg = "#EAB56B" })
nvim_set_hl(0, "Cursor", { bg = "#C9C9C9", fg = "#222222" })
nvim_set_hl(0, "CursorLine", { bg = "#2A2A2A", fg = "NONE" })
nvim_set_hl(0, "ColorColumn", { bg = "#1A1A1A", fg = "NONE" })
nvim_set_hl(0, "SignColumn", { bg = "NONE", fg = "#666967" })

-- gitsigns.nvim
nvim_set_hl(0, "GitSignsAdd", { bg = "NONE", fg = "green" })
nvim_set_hl(0, "GitSignsChange", { bg = "NONE", fg = "blue" })
nvim_set_hl(0, "GitSignsDelete", { bg = "NONE", fg = "red" })
nvim_set_hl(0, "GitSignsChange", { bg = "NONE", fg = "yellow" })

vim.defer_fn(function()
    nvim_set_hl(0, "Conceal", { bg = "NONE", fg = "#C9C9C9" })
    nvim_set_hl(0, "VertSplit", { bg = "NONE", fg = "#2e2e2e" })
    nvim_set_hl(0, "WildMenu", { bg = "#2A2A2A", fg = "#EAB56B", italic = true })
    nvim_set_hl(0, "Visual", { bg = "#343434", fg = "NONE" })
    nvim_set_hl(0, "VisualNOS", { bg = "#343434", fg = "NONE" })
    nvim_set_hl(0, "Pmenu", { bg = "#2A2A2A", fg = "NONE" })
    nvim_set_hl(0, "PmenuSbar", { bg = "#343434", fg = "NONE" })
    nvim_set_hl(0, "PmenuSel", { bg = "#343434", fg = "#998B70" })
    nvim_set_hl(0, "PmenuThumb", { bg = "#94BACA", fg = "NONE" })
    nvim_set_hl(0, "FoldColumn", { bg = "NONE", fg = "#2A2A2A" })
    nvim_set_hl(0, "Folded", { bg = "#1A1A1A", fg = "#666967" })
    nvim_set_hl(0, "SpecialKey", { bg = "NONE", fg = "#998B70" })
    nvim_set_hl(0, "IncSearch", { bg = "#EAB56B", fg = "#222222" })
    nvim_set_hl(0, "Search", { bg = "#998B70", fg = "#222222" })
    nvim_set_hl(0, "Directory", { bg = "NONE", fg = "#94BACA" })
    nvim_set_hl(0, "MatchParen", { bg = "NONE", fg = "#EAB56B", bold = true })
    nvim_set_hl(0, "SpellBad", { bg = "NONE", fg = "#A74F4F", underline = true })
    nvim_set_hl(0, "SpellCap", { bg = "NONE", fg = "#679D80", underline = true })
    nvim_set_hl(0, "SpellLocal", { bg = "NONE", fg = "#EAB56B", underline = true })
    nvim_set_hl(0, "QuickFixLine", { bg = "#1A1A1A", fg = "NONE" })
    nvim_set_hl(0, "DiffAdd", { bg = "#2A2A2A", fg = "#679D80" })
    nvim_set_hl(0, "DiffChange", { bg = "#2A2A2A", fg = "NONE" })
    nvim_set_hl(0, "DiffDelete", { bg = "#2A2A2A", fg = "#A74F4F" })
    nvim_set_hl(0, "DiffText", { bg = "#2A2A2A", fg = "#EAB56B" })
    nvim_set_hl(0, "helpHyperTextJump", { fg = "#94BACA" })
    nvim_set_hl(0, "DiagnosticError", { italic = true })
    nvim_set_hl(0, "DiagnosticWarn", { italic = true })
    nvim_set_hl(0, "DiagnosticInfo", { italic = true })
    nvim_set_hl(0, "DiagnosticHint", { italic = true })
    nvim_set_hl(0, "DiagnosticUnderlineError", { italic = true })
    nvim_set_hl(0, "DiagnosticUnderlineWarn", { italic = true })
    nvim_set_hl(0, "DiagnosticUnderlineInfo", { italic = true })
    nvim_set_hl(0, "DiagnosticUnderlineHint", { italic = true })
    nvim_set_hl(0, "DiagnosticVirtualTextError", { italic = true })
    nvim_set_hl(0, "DiagnosticVirtualTextWarn", { italic = true })
    nvim_set_hl(0, "DiagnosticVirtualTextInfo", { italic = true })
    nvim_set_hl(0, "DiagnosticVirtualTextHint", { italic = true })
    nvim_set_hl(0, "DiagnosticFloatingError", { italic = true })
    nvim_set_hl(0, "DiagnosticFloatingWarn", { italic = true })
    nvim_set_hl(0, "DiagnosticFloatingInfo", { italic = true })
    nvim_set_hl(0, "DiagnosticFloatingHint", { italic = true })
    nvim_set_hl(0, "DiagnosticSignError", { italic = true })
    nvim_set_hl(0, "DiagnosticSignWarn", { italic = true })
    nvim_set_hl(0, "DiagnosticSignInfo", { italic = true })
    nvim_set_hl(0, "DiagnosticSignHint", { italic = true })
    nvim_set_hl(0, "MsgArea", { italic = true })
end, 10)
