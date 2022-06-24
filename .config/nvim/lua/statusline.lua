_statusline = {}

vim.cmd([[ packadd nvim-gps ]])

local nvim_gps = require("nvim-gps")
nvim_gps.setup({
    disable_icons = true,
    separator = " > ",
})

_statusline.nvim_gps = function()
    local location = ""
    if nvim_gps.is_available() then
        location = nvim_gps.get_location()
    end
    if location ~= "" then
        return location
    else
        return ""
    end
end

_statusline.getCurrentDiagnostic = function()
    local bufnr = 0
    local line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
    local opts = { ["lnum"] = line_nr }

    local line_diagnostics = vim.diagnostic.get(bufnr, opts)
    if vim.tbl_isempty(line_diagnostics) then
        return
    end

    local best_diagnostic = nil

    for _, diagnostic in ipairs(line_diagnostics) do
        if best_diagnostic == nil or diagnostic.severity < best_diagnostic.severity then
            best_diagnostic = diagnostic
        end
    end

    return best_diagnostic
end

_statusline.getCurrentDiagnosticString = function()
    local diagnostic = _statusline.getCurrentDiagnostic()

    if not diagnostic or not diagnostic.message then
        return ""
    end

    local message = vim.split(diagnostic.message, "\n")[1]
    if message == vim.NIL then
        return ""
    end
    return message
end


_statusline.msg = function()
    local diag = _statusline.getCurrentDiagnosticString()
    if diag ~= "" then
        return diag
    else
        return _statusline.nvim_gps()
    end
end

-- vim.o.statusline = "%=%m%r%h%w %-8(%l : %c%) %P"
-- vim.o.statusline = "%{%v:lua._statusline.getCurrentDiagnosticString()%}%= %m%r%h%w %l:%c %P "
vim.o.statusline = "%m%f%="
-- vim.o.winbar = "%=%P %{%v:lua._statusline.nvim_gps()%} %m%f"
