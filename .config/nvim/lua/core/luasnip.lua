vim.cmd.packadd "LuaSnip"

-- slow performance
require("luasnip/loaders/from_vscode").lazy_load({
    paths = { "~/.local/share/nvim/site/pack/bundle/opt/friendly-snippets" },
    exclude = { "go" },
})

local ls = require("luasnip")

-- ls.config.setup({
--   enable_autosnippets = false,
-- })

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
        t(ft),
        t({"", "", ""}),
        i(0)
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

import "log"

func main(){{
	log.SetFlags(log.Lshortfile | log.LstdFlags)
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
        "lv",
        fmt(
            [[
log.Printf("{1}: %#+v\n", {1})
]],
            {
                i(1)
            }, {
                repeat_duplicates = true,
            }
        )
    ),
  s("example4", fmt([[
  repeat {a} with the same key {a}
  ]], {
    a = i(1, "this will be repeat")
  }, {
    repeat_duplicates = true
  })),

    s(
        "erf",
        fmt(
            [[
if err != nil {{
  log.Fatal(err)
}}

]],
            {}
        )
    ),
})

ls.add_snippets("sh", {
    s(
        "default",
        fmt(
            [[
FOO="${{VARIABLE:-DEFAULT}}"
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

-- ls.add_snippets("go", {
--   s("f", fmt("func {}({}) {} {{\n\t{}\n}}", { i(1, "name"), i(2), i(3), i(0) })),
-- })
-- require("gosnip")

local function count(_, _, old_state)
    old_state = old_state or {
        updates = 0
    }

    old_state.updates = old_state.updates + 1

    local snip = sn(nil, {
        t(tostring(old_state.updates))
    })

    snip.old_state = old_state
    return snip
end

ls.add_snippets("go",
    s("count", {
        i(1, "change to update"),
        d(2, count, { 1 })
    })
)


ls.add_snippets("lua",
    s("python3", {
        i(1, "change to update"),
    })
)

ls.add_snippets("go", {
    s(
        "ptpython3",
        fmt(
            [[
from ptpython.repl import embed; embed(globals(), locals())
]],
            {}
        )
    ),
})

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
