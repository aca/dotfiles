-- LAG on big file
-- vim.g.Illuminate_delay = 2000
-- vim.cmd.packadd "vim-illuminate"
-- require('illuminate').configure ({
--     -- providers = {
--     --     'regex',
--     -- },
-- })

vim.api.nvim_set_hl(0, "LocalHighlight", { underline = true })
vim.cmd.packadd("local-highlight.nvim")
require("local-highlight").setup({
    disable_file_types = { "text", "markdown" },
})

vim.api.nvim_create_autocmd("BufRead", {
    pattern = { "*.*" },
    callback = function(data)
        require("local-highlight").attach(data.buf)
    end,
})

-- require("local-highlight").attach(0)
