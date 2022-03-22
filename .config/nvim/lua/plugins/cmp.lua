-- https://github.com/hrsh7th/cmp-nvim-lsp

local api = vim.api

vim.cmd([[ 
packadd nvim-cmp
packadd cmp-under-comparator
packadd cmp-buffer
packadd cmp-nvim-lsp
packadd cmp-path
packadd cmp_luasnip

packadd friendly-snippets

highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])

local cmp = require("cmp")
require("cmp_nvim_lsp").setup()

cmp.register_source("path", require("cmp_path").new())

cmp.register_source("buffer", require("cmp_buffer"))

-- ~/.local/share/nvim/site/pack/bundle/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua
cmp.register_source("luasnip", require("cmp_luasnip").new())
local augroup_cmp_luasnip = api.nvim_create_augroup("cmp_luasnip", {})
api.nvim_create_autocmd("User", {
    group = augroup_cmp_luasnip,
    pattern = "LuasnipCleanup",
    callback = function()
        require("cmp_luasnip").clear_cache()
    end,
})
api.nvim_create_autocmd("User", {
    group = augroup_cmp_luasnip,
    pattern = "LuasnipSnippetsAdded",
    callback = function()
        require("cmp_luasnip").refresh()
    end,
})

local remap = api.nvim_set_keymap
local t = function(str)
    return api.nvim_replace_termcodes(str, true, true, true)
end

local cmp_sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer", option = { keyword_length = 5 } },
    { name = "luasnip" },
    { name = "copilot" },
    -- { name = 'cmp_tabnine'},
    -- { name = "vsnip" },
    -- {
    -- 	name = "tmux",
    -- 	-- option = {
    -- 	-- 	all_panes = false,
    -- 	-- },
    -- },
}

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_kinds = {
    Text = "  ",
    Method = "  ",
    Function = "λ  ",
    Constructor = "  ",
    Field = "  ",
    Variable = "  ",
    Class = "  ",
    Interface = "  ",
    Module = "  ",
    Property = "  ",
    Unit = "  ",
    Value = "  ",
    Enum = "  ",
    Keyword = "  ",
    Snippet = "  ",
    Color = "  ",
    File = "  ",
    Reference = "  ",
    Folder = "  ",
    EnumMember = "  ",
    Constant = "  ",
    Struct = "  ",
    Event = "  ",
    Operator = "  ",
    TypeParameter = "  ",
}

-- local lspkind_comparator = function(conf)
--   local lsp_types = require('cmp.types').lsp
--   return function(entry1, entry2)
--     if entry1.source.name ~= 'nvim_lsp' then
--       if entry2.source.name == 'nvim_lsp' then
--         return false
--       else
--         return nil
--       end
--     end
--     local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
--     local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]
--
--     local priority1 = conf.kind_priority[kind1] or 0
--     local priority2 = conf.kind_priority[kind2] or 0
--     if priority1 == priority2 then
--       return nil
--     end
--     return priority2 < priority1
--   end
-- end

local label_comparator = function(entry1, entry2)
    return entry1.completion_item.label < entry2.completion_item.label
end

local luasnip = require("luasnip")
cmp.setup({
    -- You should change this example to your chosen snippet engine.
    -- snippet = {
    -- 	expand = function(args)
    -- 		-- You must install `vim-vsnip` if you set up as same as the following.
    -- 		vim.fn["vsnip#anonymous"](args.body)
    -- 	end,
    -- },
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
    -- comparators = {
    --   lspkind_comparator({
    --     kind_priority = {
    --       Field = 11,
    --       Property = 11,
    --       Constant = 10,
    --       Enum = 10,
    --       EnumMember = 10,
    --       Event = 10,
    --       Function = 10,
    --       Method = 10,
    --       Operator = 10,
    --       Reference = 10,
    --       Struct = 10,
    --       Variable = 9,
    --       File = 8,
    --       Folder = 8,
    --       Class = 5,
    --       Color = 5,
    --       Module = 5,
    --       Keyword = 2,
    --       Constructor = 1,
    --       Interface = 1,
    --       Snippet = 0,
    --       Text = 1,
    --       TypeParameter = 1,
    --       Unit = 1,
    --       Value = 1,
    --     },
    --   }),
    --   label_comparator,
    -- },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
            return vim_item
        end,
    },
    -- preselect = cmp.PreselectMode.None,
    preselect = "none",
    -- You must set mapping.
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
