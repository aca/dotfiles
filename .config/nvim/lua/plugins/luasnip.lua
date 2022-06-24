vim.cmd([[
packadd LuaSnip
]])

-- slow performance
require("luasnip/loaders/from_vscode").lazy_load({ paths = { "~/.local/share/nvim/site/pack/bundle/opt/friendly-snippets" }})

-- -- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1011938524
-- function _G.leave_snippet()
--     if
--         ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i') and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()] and not require('luasnip').session.jump_active
--     then
--         require('luasnip').unlink_current()
--     end
-- end
-- vim.api.nvim_command([[
--     autocmd ModeChanged * lua leave_snippet()
-- ]])

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

local function shebang(_, _)
    local cstring = vim.split(vim.bo.commentstring, "%s", true)[1]
    if cstring == "/*" then
        cstring = "//"
    end
    cstring = vim.trim(cstring)
    local ft = vim.bo.filetype
    if ft == "python" then
        ft = "python3"
    end
    return sn(nil, {
        t(cstring),
        t("!/usr/bin/env "),
        i(1, ft),
    })
end

ls.add_snippets("all", {
    s({ trig = "bang", dscr = "Add SheBang" }, {
        d(1, shebang, {}),
    }),
})

local function get_file_name()
    return vim.fn.fnamemodify(vim.fn.bufname(), ":r")
end

ls.add_snippets("markdown", {
    s(
        "header",
        fmt(
            [[
---
title: {1}
date: {2}
tags:
---
]],
            {
                p(get_file_name),
                p(os.date, "%Y-%m-%dT%H:%M"),
            }
        )
    ),
})

ls.add_snippets("go", {
    s(
        "funch",
        fmt(
            [[
func {1}(w http.ResponseWriter, r *http.Request) {{
    {2}
}}
]],
            {
                i(1),
                i(0),
            }
        )
    ),

    s(
        "main",
        fmt(
            [[package main

func main(){{
	log.SetFlags(log.Llongfile | log.LstdFlags)
    {1} 
}}
]],
            {
                i(0),
            }
        )
    ),

    s(
        "dff",
        fmt(
            [[
defer func() {{
  {1}
}}()
]],
            {
                i(0),
            }
        )
    ),

    s(
        "errl",
        fmt(
            [[
if err != nil {{
  log.Fatal(err)
}}
]],
            {}
        )
    ),

    s(
        "ierr",
        fmt(
            [[
if err != nil {{
    return {1}
}}
]],
            {
              i(0)
            }
        )
    ),

    s(
        "logflag",
        fmt(
            [[
log.SetFlags(log.Lshortfile | log.Lmicroseconds | log.Lmsgprefix); log.SetPrefix("\033[31m")
    ]],
            {}
        )
    ),
})

ls.add_snippets("python", {
    s(
        "ptpython",
        fmt(
            [[
from ptpython.repl import embed; embed(globals(), locals())
]],
            {}
        )
    ),
})

-- -- require("luasnip.session.snippet_collection").clear_snippets "go"
--
-- local snippet_from_nodes = ls.sn
--
-- local shortcut = function(val)
--   if type(val) == "string" then
--     return { t { val }, i(0) }
--   end
--
--   if type(val) == "table" then
--     for k, v in ipairs(val) do
--       if type(v) == "string" then
--         val[k] = t { v }
--       end
--     end
--   end
--
--   return val
-- end
--
-- local same = function(index)
--   return f(function(args)
--     return args[1]
--   end, { index })
-- end
--
-- local make = function(tbl)
--   local result = {}
--   for k, v in pairs(tbl) do
--     table.insert(result, (ls.s({ trig = k, desc = v.desc }, shortcut(v))))
--   end
--
--   return result
-- end
--
-- local ts_locals = require "nvim-treesitter.locals"
-- local ts_utils = require "nvim-treesitter.ts_utils"
-- local get_node_text = vim.treesitter.get_node_text
--
-- vim.treesitter.set_query(
--   "go",
--   "LuaSnip_Result",
--   [[ [
--     (method_declaration result: (_) @id)
--     (function_declaration result: (_) @id)
--     (func_literal result: (_) @id)
--   ] ]]
-- )
--
-- local transform = function(text, info)
--   if text == "int" then
--     return t "0"
--   elseif text == "error" then
--     if info then
--       info.index = info.index + 1
--
--       return c(info.index, {
--         t(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
--         t(info.err_name),
--       })
--     else
--       return t "err"
--     end
--   elseif text == "bool" then
--     return t "false"
--   elseif text == "string" then
--     return t '""'
--   elseif string.find(text, "*", 1, true) then
--     return t "nil"
--   end
--
--   return t(text)
-- end
--
-- local handlers = {
--   ["parameter_list"] = function(node, info)
--     local result = {}
--
--     local count = node:named_child_count()
--     for idx = 0, count - 1 do
--       table.insert(result, transform(get_node_text(node:named_child(idx), 0), info))
--       if idx ~= count - 1 then
--         table.insert(result, t { ", " })
--       end
--     end
--
--     return result
--   end,
--
--   ["type_identifier"] = function(node, info)
--     local text = get_node_text(node, 0)
--     return { transform(text, info) }
--   end,
-- }
--
-- local function go_result_type(info)
--   local cursor_node = ts_utils.get_node_at_cursor()
--   local scope = ts_locals.get_scope_tree(cursor_node, 0)
--
--   local function_node
--   for _, v in ipairs(scope) do
--     if v:type() == "function_declaration" or v:type() == "method_declaration" or v:type() == "func_literal" then
--       function_node = v
--       break
--     end
--   end
--
--   local query = vim.treesitter.get_query("go", "LuaSnip_Result")
--   for _, node in query:iter_captures(function_node, 0) do
--     if handlers[node:type()] then
--       return handlers[node:type()](node, info)
--     end
--   end
-- end
--
-- local go_ret_vals = function(args)
--   return snippet_from_nodes(
--     nil,
--     go_result_type {
--       index = 0,
--       err_name = args[1][1],
--       func_name = args[2][1],
--     }
--   )
-- end
--
-- ls.add_snippets(
--   "go",
--   make {
--     main = {
--       t { "func main() {", "\t" },
--       i(0),
--       t { "", "}" },
--     },
--
--     ef = {
--       i(1, { "val" }),
--       t ", err := ",
--       i(2, { "f" }),
--       t "(",
--       i(3),
--       t ")",
--       i(0),
--     },
--
--     efi = {
--       i(1, { "val" }),
--       ", ",
--       i(2, { "err" }),
--       " := ",
--       i(3, { "f" }),
--       "(",
--       i(4),
--       ")",
--       t { "", "if " },
--       same(2),
--       t { " != nil {", "\treturn " },
--       d(5, go_ret_vals, { 2, 3 }),
--       t { "", "}" },
--       i(0),
--     },
--
--     -- TODO: Fix this up so that it actually uses the tree sitter thing
--     ie = { "if err != nil {", "\treturn err", i(0), "}" },
--   }
-- )
--
-- ls.add_snippets("go", {
--   s("f", fmt("func {}({}) {} {{\n\t{}\n}}", { i(1, "name"), i(2), i(3), i(0) })),
-- })
