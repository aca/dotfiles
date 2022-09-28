vim.cmd [[ 
    packadd nvim-treesitter
    packadd nvim-ts-rainbow
    packadd nvim-treesitter-context
    packadd nvim-treesitter-textobjects
    packadd playground
]]

-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- local query = require("vim.treesitter.query")
local install = require("nvim-treesitter.install")
install.compilers = { "gcc" }

require("nvim-treesitter.configs").setup({
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
            -- You can choose the select mode (default is charwise 'v')
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V", -- linewise
                ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding xor succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            include_surrounding_whitespace = true,
        },
    },

    indent = {
        enable = false,
    },
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
    enable = {
        "c",
        "cmake",

        "go",
        "java",
        "kotlin",
        "zig",
        "python",
        "rust",
        "julia",
        "ruby",
        "lua",
        "sql",
        "javascript",
        "typescript",
        "html",
        "css",
        "scss",
        "svelte",

        "elvish",
        "fish",
        "bash",

        "query",
        "markdown",
        "markdown_inline",
        "json",
        "json5",
        "jsonc",
        "yaml",
        "toml",
        "jsx",
    },
    -- disable = {
    -- 	"dockerfile",
    -- 	"cooklang",
    -- 	"glimmer",
    -- 	"foam",
    -- 	"m68k",
    -- 	"pioasm",
    -- 	"pug",
    --        "v",
    --        "astro",
    --        "beancount",
    --        "bibtex",
    --        "cooklang",
    --        "ecma",
    --        "eex",
    --        "fortran",
    --        "fusion",
    -- 	"norg",
    -- 	"sparql",
    -- 	"surface",
    -- 	"supercollider",
    -- 	"swift",
    -- 	"tlaplus",
    -- 	"todotxt",
    -- 	"yang",
    -- 	"ocaml",
    -- 	"ninja",
    -- 	"ocamllex",
    -- 	"ocaml_interface",
    -- 	"ql",
    -- 	"eex",
    -- 	"devicetree",
    -- 	"fortran",
    -- 	"fusion",
    -- 	"gdscript",
    -- 	"godot_resource",
    -- 	"hack",
    -- 	"hjson",
    -- 	"heex",
    -- 	"glsl",
    -- 	"gleam",
    -- 	"d",
    -- 	"lalrpop",
    -- },
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        -- NOTE: elixir TS returns error, remove this later
        disable = {
            "vim",
            "lua",
            "go",
        },
    },
})

require("treesitter-context").setup()

-- https://github.com/echasnovski/nvim/blob/34506b1682b56f1f617fd31d2dfe3c72497dd17d/lua/ec/configs/nvim-treesitter.lua#L133
-- requires folds.scm
local query = require("nvim-treesitter.query")
local parsers = require("nvim-treesitter.parsers")
local ts_utils = require("nvim-treesitter.ts_utils")

local folds_levels = ts_utils.memoize_by_buf_tick(function(bufnr)
    local parser = parsers.get_parser(bufnr)

    if not (parser and query.has_folds("markdown")) then
        return {}
    end

    local levels = {}

    -- NOTE: don't use `_recursive` variant to fold only based on markdown itself
    local matches = query.get_capture_matches(bufnr, "@fold", "folds")
    for _, m in pairs(matches) do
        local node = m.node
        local s_row, _, e_row, _ = node:range()
        local node_is_heading = node:type() == "atx_heading" or node:type() == "setext_heading"
        -- local node_is_code = node:type() == "fenced_code_block"

        -- Process heading. Start fold at start line of heading with fold level
        -- equal to header level.
        if node_is_heading then
            for child in node:iter_children() do
                local _, _, level = string.find(child:type(), "h([0-9]+)")
                if level ~= nil then
                    levels[s_row] = (">%s"):format(level)
                    break
                end
            end
        end

        -- Process code block. Add fold level at start line and subtract at end.
        -- if node_is_code then
        -- 	levels[s_row] = "a1"
        -- 	levels[e_row - 1] = "s1"
        -- end
    end

    return levels
end)

_G._markdown_foldexpr = function()
    local levels = folds_levels(vim.api.nvim_get_current_buf()) or {}
    return levels[vim.v.lnum - 1] or "="
end

vim.cmd([[
  set foldmethod=expr | set foldexpr=nvim_treesitter#foldexpr()
]])

-- for lazyload
if vim.bo.filetype == "markdown" then
    vim.cmd([[
        setlocal foldexpr=v:lua._markdown_foldexpr()
        " normal! zx
    ]])
end

-- add autocmd
vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "markdown" },
    command = "setlocal foldexpr=v:lua._markdown_foldexpr()",
})

require("vim.treesitter.query").set_query(
    "markdown",
    "highlights",
    [[
(atx_heading (inline) @text.title)
(setext_heading (paragraph) @text.title)

[
  (atx_h1_marker)
  (atx_h2_marker)
  (atx_h3_marker)
  (atx_h4_marker)
  (atx_h5_marker)
  (atx_h6_marker)
  (setext_h1_underline)
  (setext_h2_underline)
] @punctuation.special

[
  (link_title)
  (indented_code_block)
  (fenced_code_block)
] @text.literal

[
  (fenced_code_block_delimiter)
] @punctuation.delimiter

(code_fence_content) @none

[
  (link_destination)
] @text.uri

[
  (link_label)
] @text.reference

[
  (list_marker_plus)
  (list_marker_minus)
  (list_marker_star)
  (list_marker_dot)
  (list_marker_parenthesis)
  (thematic_break)
] @punctuation.special

[
  (block_continuation)
  (block_quote_marker)
] @punctuation.special

[
  (backslash_escape)
] @string.escape

([
  (info_string)
] @conceal
(#set! conceal ""))
]]
)

-- require("vim.treesitter.query").set_query("markdown", "folds", [[
-- [
--   (atx_heading)
--   (setext_heading)
-- ] @fold
-- ]])
