vim.cmd.packadd("satellite.nvim")
require("satellite").setup({
	current_only = false,
	winblend = 90,
	zindex = 50,
	excluded_filetypes = {
		-- "man",
	},
	handlers = {
		-- cursor = {
		-- 	enable = false,
		-- },
		search = {
			enable = true,
			-- Highlights:
			-- - SatelliteSearch (default links to Search)
			-- - SatelliteSearchCurrent (default links to SearchCurrent)
		},
		gitsigns = {
			enable = false,
			signs = { -- can only be a single character (multibyte is okay)
				-- add = "-",
				change = "│",
				delete = "*",
			},
			-- Highlights:
			-- SatelliteGitSignsAdd (default links to GitSignsAdd)
			-- SatelliteGitSignsChange (default links to GitSignsChange)
			-- SatelliteGitSignsDelete (default links to GitSignsDelete)
		},
	},
})
-- https://github.com/petertriho/nvim-scrollbar

-- vim.cmd([[
--    packadd nvim-hlslens
--    packadd nvim-scrollbar
-- ]])
--
-- require("scrollbar.handlers.search").setup({
-- 	-- hlslens config overrides
-- })
--
-- require("scrollbar").setup({
--     -- show_in_active_only = true,
--     handlers = {
--         cursor = false,
--     },
--     handle = {
--         color = '#242124'
--     }
-- })
--
-- require('hlslens').setup({
--     calm_down = true,
--     nearest_only = true,
--     nearest_float_when = 'always',
--     override_lens = function(render, posList, nearest, idx, relIdx)
--     end,
--
--     build_position_cb = function(plist, _, _, _)
--         require("scrollbar.handlers.search").handler.show(plist.start_pos)
--     end
-- })
--
-- vim.cmd([[
--     augroup scrollbar_search_hide
--         autocmd!
--         autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
--     augroup END
-- ]])
