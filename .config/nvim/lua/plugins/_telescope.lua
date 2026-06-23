-- NOTES(aca): disable telescope, I don't use it
-- if true then
--     return
-- end

vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("telescope.nvim")

local ok, telescope = pcall(require, "telescope")
if not ok then
	return
end

-- -- local custom_actions = {}
--
-- -- function custom_actions.fzf_multi_select(prompt_bufnr)
-- --     local picker = action_state.get_current_picker(prompt_bufnr)
-- --     local num_selections = table.getn(picker:get_multi_selection())
-- --
-- --     if num_selections > 1 then
-- --         -- actions.file_edit throws - context of picker seems to change
-- --         --actions.file_edit(prompt_bufnr)
-- --         actions.send_selected_to_qflist(prompt_bufnr)
-- --         actions.open_qflist()
-- --         vim.cmd [[ cnext ]]
-- --     else
-- --         actions.file_edit(prompt_bufnr)
-- --     end
-- -- end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_utils = require("telescope.actions.utils")
local function single_or_multi_select(prompt_bufnr)
    print("multi", "start")
	local current_picker = action_state.get_current_picker(prompt_bufnr)
	local has_multi_selection = (next(current_picker:get_multi_selection()) ~= nil)
    print("multi", has_multi_selection)

	if has_multi_selection then
		-- local results = {}
		-- action_utils.map_selections(prompt_bufnr, function(selection)
		-- 	table.insert(results, selection[1])
		-- end)
		--
		-- -- load the selections into buffers list without switching to them
		-- for _, filepath in ipairs(results) do
		-- 	-- not the same as vim.fn.bufadd!
		-- 	vim.cmd.badd({ args = { filepath } })
		-- end
		--
		-- require("telescope.pickers").on_close_prompt(prompt_bufnr)
		--
		-- -- switch to newly loaded buffers if on an empty buffer
		-- if vim.fn.bufname() == "" and not vim.bo.modified then
		-- 	vim.cmd.bwipeout()
		-- 	vim.cmd.buffer(results[1])
		-- end

		actions.send_selected_to_qflist(prompt_bufnr)
		actions.open_qflist()
		return
	else
		-- if does not have multi selection, open single file
		require("telescope.actions").file_edit(prompt_bufnr)
	end
end

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<CR>"] = single_or_multi_select,
			},
			n = {
				["<CR>"] = single_or_multi_select,
			},
		},
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix", "--follow" },
			results_title = "",
			preview_title = "",
			prompt_title = "",
			layout_config = {
				width = 0.95,
				preview_width = 0.65,
			},
		},
		grep_string = {
			results_title = "",
			preview_title = "",
			prompt_title = "",
			-- only_sort_text = true,
			mappings = {
				i = {
					-- ["<Tab>"] = "move_selection_next",
					-- ["<S-Tab>"] = "move_selection_previous",
					-- ["<cr>"] = actions.send_to_qflist,
					["<cr>"] = single_or_multi_select,
					-- ["<cr>"] =  actions.smart_send_to_qflist + actions.open_qflist + openQuickFix ,
					-- ["<cr>"] = custom_actions.fzf_multi_select,
					-- local opts = {
					--   callback = actions.toggle_selection,
					--   loop_callback = actions.send_selected_to_qflist,
					-- }
					-- require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
				},
				-- n = {
				--     ["<Tab>"] = "move_selection_next",
				--     ["<S-Tab>"] = "move_selection_previous",
				-- },
			},
		},
		-- https://github.com/nvim-telescope/telescope.nvim/issues/564
		live_grep = {
			results_title = "",
			preview_title = "",
			prompt_title = "",
			mappings = {
				i = {
					-- ["<Tab>"] = "move_selection_next",
					-- ["<S-Tab>"] = "move_selection_previous",
					-- ["<cr>"] = actions.send_to_qflist,
					-- ["<cr>"] = actions.smart_send_to_qflist + actions.open_qflist,
					-- local opts = {
					--   callback = actions.toggle_selection,
					--   loop_callback = actions.send_selected_to_qflist,
					-- }
					-- require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
				},
				-- n = {
				--     ["<Tab>"] = "move_selection_next",
				--     ["<S-Tab>"] = "move_selection_previous",
				-- },
			},
		},
	},

	defaults = {
		dynamic_preview_title = false,
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--no-ignore",
			"--smart-case",
			"--hidden",
		},
		-- prompt_prefix = "     ",
		prompt_prefix = "  >   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				-- preview_width = 0.6,
				-- results_width = 0.9,
			},
			vertical = {
				mirror = false,
			},
			width = 0.9,
			height = 0.9,
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules", ".git/" },
		-- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "absolute" },
		winblend = 0,
		borderchars = { "" },
		-- borderchars = {
		--   prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
		--   results = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
		--   preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
		-- };
		-- border = {},
		-- borderchars = {
		--   { '', '', '', '', '', '', '', ''},
		--   prompt = false,
		--   results = false,
		--   preview = false,
		-- },
		color_devicons = true,
		-- use_less = true,
		-- set_env = { ["COLORTERM"] = "truecolor" },
		-- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		-- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		-- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			i = {
				-- ["<Tab>"] = "move_selection_next",
				-- ["<S-Tab>"] = "move_selection_previous",
				-- ["<cr>"] = actions.send_to_qflist,
				-- ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				-- ['<cr>'] = custom_actions.fzf_multi_select,
				-- local opts = {
				--   callback = actions.toggle_selection,
				--   loop_callback = actions.send_selected_to_qflist,
				-- }
				-- require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
			},
			n = {
				-- ["<Tab>"] = "move_selection_next",
				-- ["<S-Tab>"] = "move_selection_previous",
				-- ["<cr>"] = custom_actions.fzf_multi_select,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
--
-- telescope.load_extension("fzf")
-- -- telescope.load_extension "node_modules"
