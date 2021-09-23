-- https://github.com/hrsh7th/cmp-nvim-lsp

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
        max_lines = 500;
        max_num_results = 4;
        sort = true;
        run_on_every_keystroke = true;
})

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.call("vsnip#jumpable", {1}) == 1 then
        return t "<Plug>(vsnip-jump-next)"
    elseif vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    else
        local next_char = vim.api.nvim_eval("strcharpart(getline('.')[col('.') - 1:], 0, 1)")
        if next_char == '"' or next_char == ")" or next_char == "'" or next_char == "]" or next_char == "}" then
            return t "<Right>"
        end
        return t "<Tab>"
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

require("cmp_nvim_lsp").setup()
local cmp = require "cmp"
local cmp_sources = {
        {name = "nvim_lsp"},
        {name = "calc"},
        {name = "vsnip"},
        {name = "path"},
        {name = 'cmp_tabnine'},
        -- {name = 'buffer'},
    }
cmp.setup {
    -- You should change this example to your chosen snippet engine.
    snippet = {
        expand = function(args)
            -- You must install `vim-vsnip` if you set up as same as the following.
            vim.fn["vsnip#anonymous"](args.body)
        end
    },
    -- preselect = cmp.PreselectMode.None,
    preselect = 'none',
    completion = {
        completeopt = 'menu,menuone,noselect',
        -- completeopt = "menu,menuone,noinsert"
    },
    -- You must set mapping.
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm(
            {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            }
        )
    },
    sources = cmp_sources,
}
