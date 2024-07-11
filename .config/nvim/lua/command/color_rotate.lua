local colorschemes = {
{ name = "lackluster" },
{ name = "duckbones" },
{ name = "forestbones" },
{ name = "kanagawabones" },
{ name = "neobones" },
{ name = "nordbones" },
{ name = "rosebones" },
{ name = "seoulbones" },
{ name = "tokyobones" },
{ name = "vimbones" },
{ name = "zenbones" },
{ name = "zenburned" },
{ name = "zenwritten" },
{ name = "blue" },
{ name = "darkblue" },
{ name = "default" },
{ name = "delek" },
{ name = "desert" },
{ name = "elflord" },
{ name = "evening" },
{ name = "habamax" },
{ name = "industry" },
{ name = "koehler" },
{ name = "lunaperche" },
{ name = "morning" },
{ name = "murphy" },
{ name = "pablo" },
{ name = "peachpuff" },
{ name = "quiet" },
{ name = "retrobox" },
{ name = "ron" },
{ name = "shine" },
{ name = "slate" },
{ name = "sorbet" },
{ name = "torte" },
{ name = "wildcharm" },
{ name = "zaibatsu" },
{ name = "zellner" },
{ name = "onedark" },
{ name = "rasmus" },
{ name = "seoul256-light" },
{ name = "seoul256" },
}

local M = {}

-- @returns the current scheme from the list above, along with it's index
function M.get_current_scheme()
  local current_scheme_name = vim.g.colors_name
  local current_background = vim.o.background or "dark"

  for i, scheme in ipairs(colorschemes) do
    local scheme_background = scheme.background or "dark"
    if scheme.name == current_scheme_name and scheme_background == current_background then
      return i, scheme
    end
  end

  return 1, colorschemes[0]
end

function M.activate_scheme(scheme)
  vim.o.background = scheme.background or "dark"
  vim.cmd(string.format("colorscheme %s", scheme.name))
end

--- Move relative the the current scheme
-- @param moves can be a negative number
function go_to_scheme(moves)
  local index, _ = M.get_current_scheme()
  local new_index = ((index + moves - 1) % #colorschemes) + 1
  local next_scheme = colorschemes[new_index]
  print(next_scheme.name)
  pcall(M.activate_scheme, next_scheme)
end

vim.api.nvim_create_user_command("ColorNext", function()
    -- require("vim.lsp.log").set_format_func(vim.inspect)
    go_to_scheme(1)
   vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
end, {})

vim.api.nvim_create_user_command("ColorPrev", function()
    -- require("vim.lsp.log").set_format_func(vim.inspect)
    go_to_scheme(-1)
   vim.api.nvim_set_hl(0, "Normal", {bg = "none"})

end, {})
vim.keymap.set("n", "]c", ":ColorPrev<cr>")
vim.keymap.set("n", "[c", ":ColorNext<cr>")

return M

