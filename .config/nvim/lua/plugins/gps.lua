vim.cmd([[
packadd nvim-gps
" packadd feline.nvim
" packadd nvim-web-devicons
]])

-- local components = require('feline.presets')["default"].components
--
-- table.insert(components.active[1], {
-- 	provider = function()
-- 		return require("nvim-gps").get_location()
-- 	end,
-- 	enabled = function()
-- 		return require("nvim-gps").is_available()
-- 	end
-- })
--
-- require('feline').setup({
--   components = components
-- })
