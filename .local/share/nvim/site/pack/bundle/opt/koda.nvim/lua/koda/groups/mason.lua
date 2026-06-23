local M = {}

local Utils = require("koda.utils")

---@type koda.HighlightsFn
function M.get_hl(c)
  -- stylua: ignore
  return {
    MasonNormal                      = { link = "Normal" },
    MasonHeader                      = { fg = c.highlight, bg = Utils.blend(c.highlight, c.bg, 0.2), bold = true },
    MasonHeaderSecondary             = { fg = c.const, bg = Utils.blend(c.const, c.bg, 0.2), bold = true },
    MasonHighlight                   = { fg = c.const },
    MasonHighlightBlock              = { fg = c.success, bg = Utils.blend(c.green, c.bg, 0.2) },
    MasonHighlightBlockBold          = { fg = c.highlight, bg = Utils.blend(c.highlight, c.bg, 0.2) },
    MasonHighlightBlockBoldSecondary = { fg = c.const, bg = Utils.blend(c.const, c.bg, 0.2) },
    MasonMutedBlock                  = { fg = c.fg, bg = c.line },
  }
end

return M
