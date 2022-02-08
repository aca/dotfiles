vim.cmd("packadd LuaSnip")
require("luasnip/loaders/from_vscode").load({
    paths = { "~/.local/share/nvim/site/pack/bundle/opt/friendly-snippets" },
})

local ls = require("luasnip")
-- some shorthands...
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

ls.snippets.all = {
    s({ trig = "bang", dscr = "Add SheBang" }, {
        d(1, shebang, {}),
    }),
}

local function get_file_name() 
  return vim.fn.fnamemodify(vim.fn.bufname(),":r") 
end

ls.snippets.markdown = {
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
            p(os.date, "%Y-%m-%dT%H:%M")
}
        )
    ),
    -- s("header", {
    --   fmt(
    --   [[
    --   {}
    --   hello
    --   world
    --   ]], {
    --     i(1, "kyung"),
    --   })
    -- }),
}
