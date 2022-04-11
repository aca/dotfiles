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
