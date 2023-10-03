vim.cmd.packadd 'conform.nvim'

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        javascript = { { "prettierd", "prettier" } },
        nix = { {"nixfmt", "alejandra" }},
    },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
