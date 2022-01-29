vim.cmd([[ 
packadd nvim-autopairs 
]])

-- require("nvim-autopairs.completion.cmp").setup({
--   map_cr = true, --  map <CR> on insert mode
--   map_complete = true, -- it will auto insert `(` after select function or method item
--   auto_select = true -- automatically select the first item
-- })

local remap = vim.api.nvim_set_keymap
local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

-- skip it, if you use another global object
_G.MUtils = {}

MUtils.completion_confirm = function()
    if vim.fn.pumvisible() ~= 0 then
        return npairs.esc("<cr>")
    else
        return npairs.autopairs_cr()
    end
end

remap("i", "<CR>", "v:lua.MUtils.completion_confirm()", { expr = true, noremap = true })

npairs.setup({
    check_ts = true,
})

-- npairs.add_rules(require("nvim-autopairs.rules.endwise-elixir"))
npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
-- npairs.add_rules(require("nvim-autopairs.rules.endwise-ruby"))

npairs.add_rule(Rule("`", "`", "-markdown"))
