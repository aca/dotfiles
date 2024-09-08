-- if not pcall(require, "nvim-treesitter") then
-- 	return
-- end

-- vim.cmd.packadd("render-markdown.nvim")
-- require("render-markdown").setup({})
-- require('render-markdown').setup({})
--
-- vim.cmd.packadd("markview.nvim")
-- -- require("render-markdown").setup({})
-- require("markview").setup({
-- })


vim.cmd.packadd "github-preview.nvim"

require("github-preview").setup({
    host = "localhost",

    -- port used by local server
    port = 6041,

    -- set to "true" to force single-file mode & disable repository mode
    single_file = false,

    theme = {
        -- "system" | "light" | "dark"
        name = "system",
        high_contrast = false,
    },

    -- define how to render <details> tags on init/content-change
    -- true: <details> tags are rendered open
    -- false: <details> tags are rendered closed
    details_tags_open = true,

    cursor_line = {
        disable = false,

        -- CSS color
        -- if you provide an invalid value, cursorline will be invisible
        color = "#c86414",
        opacity = 0.2,
    },

    scroll = {
        disable = false,

        -- Between 0 and 100
        -- VERY LOW and VERY HIGH numbers might result in cursorline out of screen
        top_offset_pct = 35,
    },

    -- for debugging
    -- nil | "debug" | "verbose"
    log_level = nil,
})
