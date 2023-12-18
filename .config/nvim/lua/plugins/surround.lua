-- vim.cmd.packadd "nvim-surround"
vim.cmd.packadd "mini.nvim"

require('mini.surround').setup({
    -- Add custom surroundings to be used on top of builtin ones. For more
    -- information with examples, see `:h MiniSurround.config`.
    custom_surroundings = {
        ["c"] = {
            -- https://github.com/echasnovski/mini.nvim/discussions/462
            output = function()
                -- is_visual doesn't work
                -- local is_visual = vim.tbl_contains({ 'v', 'V', '\22' }, vim.fn.mode())
                -- local mark_from = is_visual and "'<" or "'["
                -- local mark_to = is_visual and "'>" or "']"
                local mark_from = "'<"
                local mark_to = "'>"
                local startline = vim.fn.line(mark_from)
                local endline = vim.fn.line(mark_to)
                local n_content_lines = endline - startline
                if n_content_lines == 0 then
                    return { left = "`", right = "`" }
                end
                local firstline = vim.api.nvim_buf_get_lines(0, startline - 1, startline, false)
                local _, indent = string.find(firstline[1], '^%s*')
                if indent ~= nil then
                    return { left = "```\n" .. string.rep(" ", indent) , right = "\n" .. string.rep(" ", indent) .. "```\n" }
                else
                    return { left = "```\n", right = "\n```\n" }
                end
            end,
        },
    },
    --
    -- -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
    -- highlight_duration = 500,
    --
    -- -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      add = 'S', -- Add surrounding in Normal and Visual modes
      delete = 'ds', -- Delete surrounding
      find = 'sf', -- Find surrounding (to the right)
      find_left = 'sF', -- Find surrounding (to the left)
      highlight = 'sh', -- Highlight surrounding
      replace = 'cs', -- Replace surrounding
      update_n_lines = 'sn', -- Update `n_lines`

      suffix_last = 'l', -- Suffix to search with "prev" method
      suffix_next = 'n', -- Suffix to search with "next" method
    },
    --
    -- -- Number of lines within which surrounding is searched
    -- n_lines = 20,
    --
    -- -- Whether to respect selection type:
    -- -- - Place surroundings on separate lines in linewise mode.
    -- -- - Place surroundings on each line in blockwise mode.
    -- respect_selection_type = false,
    --
    -- -- How to search for surrounding (first inside current line, then inside
    -- -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
    -- -- see `:h MiniSurround.config`.
    -- search_method = 'cover',
    --
    -- -- Whether to disable showing non-error feedback
    -- silent = false,
})


