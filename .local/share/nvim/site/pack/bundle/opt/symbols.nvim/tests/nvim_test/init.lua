vim.cmd("let &rtp.=','.getcwd()")
require("symbols").setup()

vim.cmd("set runtimepath+=deps/nvim-treesitter")
require("nvim-treesitter.configs").setup({
    ensure_installed = { "markdown", "org", "vimdoc", "json", "make" },
    auto_install = true,
})

vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = "lua",
        callback = function(_)
            vim.lsp.start({
                cmd = { "deps/lua-language-server/bin/lua-language-server" },
                single_file_support = true,
            })
        end,
    }
)

vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = "ruby",
        callback = function(_)
            vim.lsp.start({
                cmd = { "./scripts/solograph.sh" },
                single_file_support = true,
            })
        end,
    }
)
