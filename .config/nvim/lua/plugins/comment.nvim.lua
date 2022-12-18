-- vim.cmd.packadd("tcomment_vim")
require("Comment").setup({
    mappings = {
        basic = true,
        extra = false,
        extended = false,
    },
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    },

    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),

    -- pre_hook = function(ctx)
    --     -- TODO: https://github.com/numToStr/Comment.nvim/pull/133 remove nvim-ts-context-commentstring?
    --     -- require('Comment.jsx').calculate(ctx)
    --     require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    --
    --     -- local ft = vim.bo.filetype
    --     -- tsx
    --     -- if ft == "typescriptreact" or ft == "javascriptreact" then
    --     -- local U = require("Comment.utils")
    --     --
    --     -- -- Detemine whether to use linewise or blockwise commentstring
    --     -- local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
    --     --
    --     -- -- Determine the location where to calculate commentstring from
    --     -- local location = nil
    --     -- if ctx.ctype == U.ctype.block then
    --     -- 	location = require("ts_context_commentstring.utils").get_cursor_location()
    --     -- elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
    --     -- 	location = require("ts_context_commentstring.utils").get_visual_start_location()
    --     -- end
    --     --
    --     -- return require("ts_context_commentstring.internal").calculate_commentstring({
    --     -- 	key = type,
    --     -- 	location = location,
    --     -- })
    --     --
    --
    --     -- plain text
    --     -- elseif ft == "text" then
    --     -- 	vim.bo.commentstring = "# %s"
    --     -- end
    -- end,
})
--
-- local ft = require('Comment.ft')
-- ft.set('elvish', '# %s')
-- ft.set('json', '// %s')
