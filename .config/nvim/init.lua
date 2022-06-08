local xdg_config = vim.fn.stdpath("config") .. "/lua"
dofile(xdg_config .. "/settings.lua")
dofile(xdg_config .. "/colors.lua")
dofile(xdg_config .. "/autocmds.lua")
dofile(xdg_config .. "/lazy.lua")
