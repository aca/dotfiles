-- https://github.com/hrsh7th/cmp-nvim-lsp

local api = vim.api

vim.cmd([[ 
packadd nvim-cmp
packadd cmp-under-comparator

packadd cmp-buffer
runtime after/plugin/cmp_buffer.lua

packadd cmp-nvim-lsp
runtime after/plugin/cmp_nvim_lsp.lua

packadd cmp-path
runtime after/plugin/cmp_path.lua

packadd cmp_luasnip
runtime /after/plugin/cmp_luasnip.lua

packadd cmp-nvim-lsp-signature-help
runtime after/plugin/cmp_nvim_lsp_signature_help.lua

" packadd friendly-snippets

]])

local cmp = require("cmp")

local cmp_sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer", option = { keyword_length = 5 } },
    { name = "luasnip" },
    { name = "nvim_lsp_signature_help" },
}

-- local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

local cmp_kinds = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

local luasnip = require("luasnip")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require("cmp-under-comparator").under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
            return vim_item
        end,
    },
    preselect = "none",
    mapping = {
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.core.view:get_selected_entry() then
                cmp.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                })
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<c-e>"] = cmp.mapping(function(fallback)
            if luasnip.expandable() then
                require("luasnip").expand()
            else
                fallback()
            end
        end, {
            "i",
        }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            local next_char = vim.api.nvim_eval("strcharpart(getline('.')[col('.') - 1:], 0, 1)")
            if false then
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif cmp.visible() then
                cmp.select_next_item()
                -- require("luasnip").unlink_current()
            elseif
                next_char == '"'
                or next_char == ")"
                or next_char == "'"
                or next_char == "]"
                or next_char == "}"
                or next_char == "("
            then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, true, true), "n", true)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            elseif cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },
    sources = cmp_sources,
})
