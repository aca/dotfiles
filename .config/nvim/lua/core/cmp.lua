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

packadd cmp-cmdline
runtime after/plugin/cmp_cmdline.lua

packadd cmp-tmux
runtime after/plugin/cmp_tmux.vim

" packadd copilot.vim
" packadd cmp-copilot
" packadd cmp-tabnine
" runtime after/plugin/cmp-tabnine.lua

" packadd friendly-snippets
]])

local cmp = require("cmp")

-- local tabnine = require("cmp_tabnine.config")
-- tabnine.setup({
--     max_lines = 1000,
--     max_num_results = 20,
--     sort = true,
--     run_on_every_keystroke = true,
--     snippet_placeholder = "..",
--     ignored_file_types = {
--         lua = true,
--     },
--     show_prediction_strength = false,
-- })

local cmp_sources = {
    { name = "nvim_lsp" },
    -- { name = "copilot" },
    -- { name = "tabnine" },
    -- { name = "path" },
    { name = "buffer", option = { keyword_length = 5 } },
    { name = "luasnip" },
    { name = "nvim_lsp_signature_help" },
}

-- local cmp_kinds = {
--     Text = "",
--     Method = "",
--     Function = "",
--     Constructor = "",
--     Field = "",
--     Variable = "",
--     Class = "ﴯ",
--     Interface = "",
--     Module = "",
--     Property = "ﰠ",
--     Unit = "",
--     Value = "",
--     Enum = "",
--     Keyword = "",
--     Snippet = "",
--     Color = "",
--     File = "",
--     Reference = "",
--     Folder = "",
--     EnumMember = "",
--     Constant = "",
--     Struct = "",
--     Event = "",
--     Operator = "",
--     TypeParameter = "",
-- }

-- local cmp_kinds = {
--     Text = "",
--     Method = "",
--     Function = "",
--     Constructor = "⌘",
--     Field = "ﰠ",
--     Variable = "",
--     Class = "ﴯ",
--     Interface = "",
--     Module = "",
--     Property = "ﰠ",
--     Unit = "塞",
--     Value = "",
--     Enum = "",
--     Keyword = "廓",
--     Snippet = "",
--     Color = "",
--     File = "",
--     Reference = "",
--     Folder = "",
--     EnumMember = "",
--     Constant = "",
--     Struct = "פּ",
--     Event = "",
--     Operator = "",
--     TypeParameter = "",
-- }

local luasnip = require("luasnip")
cmp.setup({
    -- documentation = { -- no border; native-style scrollbar
    --   border = nil,
    --   scrollbar = '',
    --   -- other options
    -- },
    -- window = {
    --     completion = cmp.config.window.bordered(),
    --     documentation = cmp.config.window.bordered(),
    -- },

    experimental = {
        native_menu = false,
        ghost_text = false,
    },
    -- confirmation = {
    --     get_commit_characters = function()
    --         return {}
    --     end,
    -- },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    -- sorting = {
    --     comparators = {
    --         cmp.config.compare.offset,
    --         cmp.config.compare.exact,
    --         cmp.config.compare.score,
    --         require("cmp-under-comparator").under,
    --         cmp.config.compare.kind,
    --         cmp.config.compare.sort_text,
    --         cmp.config.compare.length,
    --         cmp.config.compare.order,
    --     },
    -- },

    -- formatting = {
    --     -- format = function(_, vim_item)
    --     --     vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
    --     --     return vim_item
    --     -- end,
    --     fields = { "kind", "abbr", "menu" },
    --     format = function(_, vim_item)
    --         vim_item.menu = vim_item.kind
    --         vim_item.kind = cmp_kinds[vim_item.kind]
    --
    --         return vim_item
    --     end,
    -- },
    --
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
                -- luasnip.unlink_current()
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
            "n",
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

-- require'cmp'.setup.cmdline(':', {
--   sources = {
--     { name = 'cmdline' }
--   }
-- })
--
-- require'cmp'.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' }
--   }
-- })
