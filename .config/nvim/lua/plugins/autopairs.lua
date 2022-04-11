vim.cmd([[ 
  packadd nvim-autopairs 
]])

local npairs = require("nvim-autopairs")
-- local Rule = require("nvim-autopairs.rule")

-- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- local cmp = require('cmp')
-- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

npairs.setup({
    check_ts = true,
    disable_in_visualblock = true,
    disable_in_macro = true,
})

-- npairs.add_rules(require("nvim-autopairs.rules.endwise-elixir"))
-- npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
-- npairs.add_rules(require("nvim-autopairs.rules.endwise-ruby"))
-- npairs.add_rule(Rule("`", "`", "-markdown"))
