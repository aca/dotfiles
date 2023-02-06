vim.cmd.packadd("alpha-nvim")
vim.keymap.set("n", "<leader>x", ":Alpha<cr>")

local alpha = require("alpha")
local startify = require("alpha.themes.startify")

startify.section.header.val = {}

startify.section.top_buttons.val = {}

local function mru_title()
    return "MRU " .. vim.fn.getcwd()
end

startify.section.mru_cwd.val = {
    { type = "padding", val = 1 },
    { type = "text", val = mru_title, opts = { hl = "SpecialComment", shrink_margin = false } },
    { type = "padding", val = 1 },
    {
        type = "group",
        val = function()
            return { startify.mru(30, vim.fn.getcwd()) }
        end,
        opts = { shrink_margin = false },
    },
}

startify.section.mru.val = {
    { type = "padding", val = 1 },
    { type = "text", val = "MRU", opts = { hl = "SpecialComment" } },
    { type = "padding", val = 1 },
    {
        type = "group",
        val = function()
            return { startify.mru(0, false, 30) }
        end,
    },
}
-- disable nvim_web_devicons
startify.nvim_web_devicons.enabled = false
-- startify.nvim_web_devicons.highlight = false
-- startify.nvim_web_devicons.highlight = 'Keyword'
--
startify.section.bottom_buttons.val = {}
startify.section.footer = {
    { type = "text", val = "footer" },
}

local default_mru_ignore = { "gitcommit" }
startify.mru_opts.ignore = function(path, ext)
    return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
end

alpha.setup(startify.config)
