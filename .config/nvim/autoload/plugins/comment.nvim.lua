vim.cmd([[ 
  packadd Comment.nvim 
  runtime after/plugin/Comment.lua

  packadd nvim-ts-context-commentstring
]])

require("Comment").setup({
    mappings = {
        basic = true,
        extra = false,
        extended = false,
    },
    pre_hook = function(ctx)
        local ft = vim.bo.filetype

        -- tsx
        if ft == "typescriptreact" then
            local U = require("Comment.utils")

            -- Detemine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.block then
                location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring.internal").calculate_commentstring({
                key = type,
                location = location,
            })

        -- plain text
        elseif ft == "text" then
            vim.bo.commentstring = "# %s"
        end
    end,
})

-- local ft = require('Comment.ft')
-- ft.set('javascript', {'//%s', '/*%s*/'}).set('conf', '#%s')
-- ft.set('typescript', {'//%s', '/*%s*/'}).set('conf', '#%s')
