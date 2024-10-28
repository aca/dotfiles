local vim = vim

vim.cmd([[

packadd lspkind.nvim

packadd nvim-cmp
packadd cmp-under-comparator

packadd cmp-function
runtime after/plugin/cmp_function.lua

packadd cmp-buffer
runtime after/plugin/cmp_buffer.lua

packadd cmp-nvim-lsp
runtime after/plugin/cmp_nvim_lsp.lua

packadd cmp-path
runtime after/plugin/cmp_path.lua

packadd nvim-autopairs

" packadd vim-dadbod-completion
" runtime after/plugin/vim_dadbod_completion.lua

" packadd cmp-omni
" runtime /after/plugin/cmp_omni.lua

packadd cmp-nvim-lsp-signature-help
runtime after/plugin/cmp_nvim_lsp_signature_help.lua

" packadd cmp-tmux
" runtime after/plugin/cmp_tmux.vim

" packadd cmp-luasnip-choice
" runtime after/plugin/cmp_luasnip_choice.lua

" MAYBE(aca): https://github.com/zbirenbaum/copilot-cmp
" packadd copilot.vim
" packadd cmp-copilot

" packadd cmp-tabnine
" runtime after/plugin/cmp-tabnine.lua

" packadd cmp-dynamic
" runtime after/plugin/cmp_dynamic.lua

packadd cmp-cmdline
runtime after/plugin/cmp_cmdline.lua
]])

local use_luasnip = false
if pcall(require, "luasnip") then
	use_luasnip = true
	vim.cmd([[
    packadd cmp_luasnip
    runtime after/plugin/cmp_luasnip.lua
    ]])
end

local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- local function go_iferr()
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<c-f>', true, false, true), 'm', true)
--     local boff = vim.fn.wordcount().cursor_bytes
--     local cmd = ('iferr' .. ' -pos ' .. boff)
--     ---@diagnostic disable-next-line: param-type-mismatch
--     local data = vim.fn.systemlist(cmd, vim.fn.bufnr("%"))
--     if vim.v.shell_error ~= 0 then
--         print("error", vim.v.shell_error)
--         return
--     end
--     local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
--     vim.api.nvim_buf_set_lines(0, r - 1, r, true, data)
--     vim.cmd([[silent normal! kj=2jjjo]])
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<c-f>', true, false, true), 'm', true)
-- end

-- local function go_ret()
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<c-f>', true, false, true), 'm', true)
--     local boff = vim.fn.wordcount().cursor_bytes
--     local cmd = ('iferr' .. ' -ret -pos ' .. boff)
--     ---@diagnostic disable-next-line: param-type-mismatch
--     local data = vim.fn.systemlist(cmd, vim.fn.bufnr("%"))
--     if vim.v.shell_error ~= 0 then
--         print("error", vim.v.shell_error)
--         return
--     end
--     local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
--     vim.api.nvim_buf_set_lines(0, r - 1, r, true, data)
--     vim.cmd([[silent normal! kj=2jo]])
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<c-f>', true, false, true), 'm', true)
-- end

-- -- https://github.com/golang/go/issues/49018
-- require('cmp_function').register({
--     {
--         label = 'ret',
--         kind = 15,
--         documentation = "ret",
--         func = go_ret
--     }
-- })

-- require('cmp_luasnip_choice').setup({
--     auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
-- });

local cmp_sources = {}

if vim.env.VIM_DISABLE_LSP == "1" then
	cmp_sources = {
		-- { name = "nvim_lsp" },
		-- { name = "copilot" },
		-- { name = "tabnine" },
		{ name = "tmux" },
		-- { name = "omni" },
		{ name = "buffer", option = { keyword_length = 4 } },
		-- { name = "luasnip" },
		-- { name = "nvim_lsp_signature_help" },
		-- { name = "luasnip_choice" },
	}
else
	cmp_sources = {
		{ name = "nvim_lsp" },
		{ name = "vim-dadbod-completion" },
		-- { name = "function" },
		-- { name = "emoji", insert = true },
		-- { name = "copilot", group_index = 2 },
		-- { name = "copilot" },
		-- { name = "copilot" },
		-- { name = "tabnine" },
		-- { name = "path" },
		-- { name = "buffer", option = { keyword_length = 5 } },
		-- { name = "luasnip" },
		{ name = "nvim_lsp_signature_help" },
		-- { name = "luasnip_choice" },
		-- { name = "path", option = { } }
	}
end

table.insert(cmp_sources, { name = "luasnip" })

-- -- Set configuration for specific filetype.
--  cmp.setup.filetype('gitcommit', {
--    sources = cmp.config.sources({
--      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--    }, {
--      { name = 'buffer' },
--    })
--  })

local has_words_before = function()
	-- if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
	--
	-- api is deprecated, NOT SURE THIS IS CORRECT
	if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
		return false
	end

	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
	},
	formatting = {
        expandable_indicator = true,
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			-- kind.menu = "    (" .. (strings[2] or "") .. ")"

			return kind
		end,
	},
	-- window = {
	-- 	-- completion = cmp.config.window.bordered(),
	-- 	-- documentation = cmp.config.window.bordered(),
	-- 	-- documentation = { -- no border; native-style scrollbar
	-- 	--   border = nil,
	-- 	--   -- scrollbar = '',
	-- 	--   -- other options
	-- 	-- },
	-- },
	--
	-- experimental = {
	-- 	ghost_text = false,
	-- },
	-- confirmation = {
	--     get_commit_characters = function()
	--         return {}
	--     end,
	-- },

	snippet = {
		expand = function(args)
			if use_luasnip then
				require("luasnip").lsp_expand(args.body)
			else
				vim.snippet.expand(args.body)
			end
		end,
	},

	-- enabled = function()
	-- 	return not luasnip.jumpable(1)
	-- end,

	preselect = "none",

	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-x>"] = cmp.mapping.close(), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		-- ["<CR>"] = cmp.mapping(function(fallback)
		--     if cmp.core.view:get_selected_entry() then
		--         cmp.confirm({
		--             behavior = cmp.ConfirmBehavior.Replace,
		--             select = true,
		--         })
		--     else
		--         fallback()
		--     end
		-- end, {
		--     "i",
		--     "s",
		-- }),
		-- ["<c-e>"] = cmp.mapping(function(fallback)
		--     if luasnip.expandable() then
		--         require("luasnip").expand()
		--     else
		--         fallback()
		--     end
		-- end, {
		--     "i",
		-- }),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

		-- ["<Tab>"] = cmp.mapping(function(fallback)
		--     -- local next_char = vim.api.nvim_eval("strcharpart(getline('.')[col('.') - 1:], 0, 1)")
		--     if cmp.visible() then
		--         cmp.select_next_item()
		--     elseif luasnip.jumpable(1) then
		--         luasnip.jump(1)
		--         -- luasnip.unlink_current()
		--         -- elseif
		--         --     next_char == '"'
		--         --     or next_char == ")"
		--         --     or next_char == "'"
		--         --     or next_char == "]"
		--         --     or next_char == "}"
		--         --     or next_char == "("
		--         -- then
		--         --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, true, true), "n", true)
		--     else
		--         fallback()
		--     end
		-- end, {
		--     "i",
		--     "s",
		--     "n",
		-- }),

		["<Tab>"] = vim.schedule_wrap(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end),

		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			-- elseif luasnip.jumpable(-1) then
			-- 	luasnip.jump(-1)
			-- 	-- vim.snippet.jump(-1)
			else
				fallback()
			end
		end,
	},
	sources = cmp_sources,
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})

vim.defer_fn(function()
	vim.cmd([[
packadd cmp-emoji
runtime after/plugin/cmp_emoji.lua
]])
end, 100)

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
