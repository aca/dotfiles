-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- local query = require("vim.treesitter.query")
local install = require("nvim-treesitter.install")
install.compilers = { "gcc" }

require("nvim-treesitter.configs").setup({
    playground = {
        enable = true,
    },
    -- matchup = {
    --     enable = true,
    -- },
    rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 150, -- Do not enable for files with more than 1000 lines, int
    },
    -- incremental_selection = {
    --     enable = true,
    --     keymaps = {
    --         -- init_selection = "<CR>",
    --         -- scope_incremental = "<CR>",
    --         init_selection = "<tab>",
    --         -- scope_incremental = "<TAB>",
    --         node_incremental = "<tab>",
    --         node_decremental = "<s-tab>",
    --     },
    -- },
    -- enable = "all",
    -- NOTE: elixir TS returns error, remove this later
    disable = {
        "elixir",
        "dockerfile",
        "cooklang",
        "glimmer",
        "foam",
        "m68k",
        "pioasm",
        "pug",
        "norg",
        "sparql",
        "surface",
        "supercollider",
        "swift",
        "tlaplus",
        "todotxt",
        "yang",
        "ocaml",
        "ninja",
        "ocamllex",
        "ocaml_interface",
        "ql",
        "eex",
        "devicetree",
        "fortran",
        "fusion",
        "gdscript",
        "godot_resource",
        "hack",
        "hjson",
        "heex",
        "glsl",
        "gleam",
        "d",
        "lalrpop",
    },
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = false,
        additional_vim_regex_highlighting = false,
        -- NOTE: elixir TS returns error, remove this later
        disable = {
            "elixir",
        },
    },
})

-- require'treesitter-context'.setup()
