-- https://github.com/hrsh7th/cmp-nvim-lsp

vim.cmd([[ 
packadd nvim-cmp
packadd cmp-buffer
packadd cmp-nvim-lsp
packadd cmp-path
packadd cmp-copilot

" packadd cmp-tmux

packadd friendly-snippets
packadd cmp_luasnip
]])

local cmp = require("cmp")
require("cmp_nvim_lsp").setup()
cmp.register_source("path", require("cmp_path").new())
cmp.register_source("buffer", require("cmp_buffer"))

-- Luasnip [[
-- ~/.local/share/nvim/site/pack/paqs/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua
cmp.register_source("luasnip", require("cmp_luasnip").new())
vim.api.nvim_exec(
    [[
  augroup cmp_luasnip
    au!
    autocmd User LuasnipCleanup lua require'cmp_luasnip'.clear_cache()
    autocmd User LuasnipSnippetsAdded lua require'cmp_luasnip'.refresh()
  augroup END
]],
    false
)
-- ]]

-- vim.g.vsnip_filetypes = {
-- 	javascriptreact = { "javascript" },
-- 	sh = { "bash" },
-- 	typescriptreact = { "typescript", "javascript" },
-- 	vimspec = { "vim" },
-- }
--
-- vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets"

local remap = vim.api.nvim_set_keymap
local npairs = require("nvim-autopairs")

-- local tabnine = require('cmp_tabnine.config')
-- tabnine:setup({
--         max_lines = 500;
--         max_num_results = 4;
--         sort = true;
--         run_on_every_keystroke = true;
-- })

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
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
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ["<Tab>"] = function(fallback)
            local next_char = vim.api.nvim_eval("strcharpart(getline('.')[col('.') - 1:], 0, 1)")
            if cmp.visible() then
                cmp.select_next_item()
                require('luasnip').unlink_current()
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif next_char == '"' or next_char == ")" or next_char == "'" or next_char == "]" or next_char == "}" then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, true, true), "n", true)
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
                -- elseif vim.fn["vsnip#available"]() == 1 then
                -- 	vim.fn.feedkeys(t("<Plug>(vsnip-jump-prev)"), "")
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
    },
    sources = cmp_sources,
})
