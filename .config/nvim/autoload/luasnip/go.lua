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

ls.snippets.go = {
    s(
        "dff",
        fmt(
            [[
defer func() {{
  {1}
}}()
]],
            {
                i(1),
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
        fmt([[
log.SetFlags(log.Lshortfile | log.Lmicroseconds | log.Lmsgprefix); log.SetPrefix("\033[31m")
    ]],{})
    ),
}
