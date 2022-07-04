local xdg_config = vim.fn.stdpath("config") .. "/lua"
dofile(xdg_config .. "/settings.lua")
dofile(xdg_config .. "/colors/monotone.lua")
dofile(xdg_config .. "/autocmds.lua")
dofile(xdg_config .. "/lazy.lua")

function _G.P(...)
  vim.pretty_print(...)
end
