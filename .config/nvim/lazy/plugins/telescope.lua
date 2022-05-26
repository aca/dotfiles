local ok, telescope = pcall(require, "telescope")

if not ok then
    return
end

-- https://github.com/thanhvule0310/dotfiles/blob/main/nvim/lua/plugins/configs/telescope.lua

telescope.setup {
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix" },
        results_title = "",
        preview_title = "",
        prompt_title = "";
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
        prompt_prefix = "     ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.6,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.95,
            height = 0.9,
            preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules", ".git/", },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "absolute" },
        winblend = 20,
        borderchars = {""},
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
        -- mappings = {
        --     i = {
        --         ["<Tab>"] = "move_selection_next",
        --         ["<S-Tab>"] = "move_selection_previous",
        --     },
        --     n = {
        --         ["<Tab>"] = "move_selection_next",
        --         ["<S-Tab>"] = "move_selection_previous",
        --     },
        -- },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
}

telescope.load_extension "fzf"
-- telescope.load_extension "node_modules"
