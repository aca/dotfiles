local M = {}

---@type koda.HighlightsFn
function M.get_hl(c)
  -- stylua: ignore
  return {
    NeoTreeGitModified   = { fg = c.warning },
    NeoTreeGitAdded      = { fg = c.success },
    NeoTreeGitDeleted    = { fg = c.danger, strikethrough = true },
    NeoTreeGitStaged     = { fg = c.success },
    NeoTreeGitConflict   = { fg = c.red },
    NeoTreeGitUntracked  = { fg = c.orange },
    NeoTreeGitUnstaged   = { fg = c.orange },
  }
end

return M
