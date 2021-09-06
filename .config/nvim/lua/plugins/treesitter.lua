-- if os.getenv("USER") ~= "rok" then
--     return
-- end

vim.cmd [[
        packadd playground
        packadd nvim-treesitter
        packadd nvim-ts-rainbow
]]

require "nvim-treesitter.configs".setup {
    playground = {
        enable = true
    },
    matchup = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 200 -- Do not enable for files with more than 1000 lines, int
    },
    -- ensure_installed = "all",
    ensure_installed = "maintained",
    autopairs = {enable = true},
    highlight = {
        enable = true
    }
}
