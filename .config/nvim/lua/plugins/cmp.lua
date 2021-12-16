-- https://github.com/hrsh7th/cmp-nvim-lsp

vim.cmd([[ 
packadd nvim-cmp
packadd cmp-buffer
packadd cmp-nvim-lsp
packadd cmp-path
packadd cmp-tmux
]])

-- lazy load
-- require("cmp").register_source("path", require("cmp_path").new())

vim.g.vsnip_filetypes = {
	javascriptreact = { "javascript" },
	sh = { "bash" },
	typescriptreact = { "typescript", "javascript" },
	vimspec = { "vim" },
}

vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets"

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

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
	print("tab complete")
	if vim.fn.call("vsnip#jumpable", { 1 }) == 1 then
		print("1")
		return t("<Plug>(vsnip-jump-next)")
	elseif vim.fn.pumvisible() == 1 then
		print("2")
		return t("<C-n>")
	else
		print("3")
		local next_char = vim.api.nvim_eval("strcharpart(getline('.')[col('.') - 1:], 0, 1)")
		if next_char == '"' or next_char == ")" or next_char == "'" or next_char == "]" or next_char == "}" then
			return t("<Right>")
		end
		return t("<Tab>")
	end
end

_G.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t("<C-p>")
	elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
		return t("<Plug>(vsnip-jump-prev)")
	else
		return t("<S-Tab>")
	end
end

require("cmp_nvim_lsp").setup()
local cmp = require("cmp")
local cmp_sources = {
	{ name = "nvim_lsp" },
	{ name = "path" },
	-- { name = 'cmp_tabnine'},
	{ name = "vsnip" },
	{ name = "buffer" },
	-- {
	-- 	name = "tmux",
	-- 	option = {
	-- 		all_panes = false,
	-- 	},
	-- },
}

cmp.setup({
	-- You should change this example to your chosen snippet engine.
	snippet = {
		expand = function(args)
			-- You must install `vim-vsnip` if you set up as same as the following.
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	-- preselect = cmp.PreselectMode.None,
	preselect = "none",
	completion = {
		completeopt = "menu,menuone,noselect",
		-- completeopt = "menu,menuone,noinsert"
	},
	-- You must set mapping.
	mapping = {
		-- ["<C-p>"] = cmp.mapping.select_prev_item(),
		-- ["<C-n>"] = cmp.mapping.select_next_item(),
		-- -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
		-- -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- ["<C-Space>"] = cmp.mapping.complete(),
		-- ["<C-e>"] = cmp.mapping.close(),
		-- ["<CR>"] = cmp.mapping(function(fallback)
		-- 	if vim.fn.complete_info()["selected"] ~= -1 then
		-- 		cmp.confirm({
		-- 			behavior = cmp.ConfirmBehavior.Replace,
		-- 			select = true,
		-- 		})
		-- 	else
		-- 		fallback()
		-- 		-- vim.fn.feedkeys(t("<cr>"), "n")
		-- 	end
		-- end, {
		-- 	"i",
		-- 	"s",
		-- }),
		--
		--
		["<CR>"] = cmp.mapping(function(fallback)
			-- if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
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
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- elseif vim.fn["vsnip#available"]() == 1 then
				-- 	vim.fn.feedkeys(t("<Plug>(vsnip-expand-or-jump)"), "")
			else
				local next_char = vim.api.nvim_eval("strcharpart(getline('.')[col('.') - 1:], 0, 1)")
				if next_char == '"' or next_char == ")" or next_char == "'" or next_char == "]" or next_char == "}" then
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, true, true), "n", true)
				else
					fallback()
				end
				-- return t("<Tab>")
				-- vim.api.nvim_feedkeys("\t", "n", true)
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"]() == 1 then
				vim.fn.feedkeys(t("<Plug>(vsnip-jump-prev)"), "")
			else
				fallback()
			end
		end,
	},
	sources = cmp_sources,
})
