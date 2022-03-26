-- https://github.com/lewis6991/gitsigns.nvim
vim.cmd([[
  packadd gitsigns.nvim
]])

require("gitsigns").setup({
    signs = {
        add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    numhl = false,
    linehl = false,
    signcolumn = true,
    -- keymaps = {
    --     -- Default keymap options
    --     noremap = false,
    --     buffer = true,
    --     ["n ]h"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
    --     ["n [h"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },
    --
    --     ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    --     ["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    --     ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    --     ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    --     ["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    --     ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    --     ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    --     ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    --     ["n <leader>hS"] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    --     ["n <leader>hU"] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
    -- },
    watch_gitdir = {
      interval = 1000,
      follow_files = true
    },
    -- current_line_blame = false,
    -- current_line_blame_delay = 1000,
    -- current_line_blame_position = "eol",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          return ']c'
        else
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end
      end, {expr=true})

      map('n', '[c', function()
        if vim.wo.diff then
          return '[c'
        else
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end
      end, {expr=true})

      -- Actions
      map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
      map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
      map('n', '<leader>hS', gs.stage_buffer)
      map('n', '<leader>hu', gs.undo_stage_hunk)
      map('n', '<leader>hR', gs.reset_buffer)
      map('n', '<leader>hp', gs.preview_hunk)
      map('n', '<leader>hb', function() gs.blame_line{full=true} end)
      map('n', '<leader>tb', gs.toggle_current_line_blame)
      map('n', '<leader>hd', gs.diffthis)
      map('n', '<leader>hD', function() gs.diffthis('~') end)
      map('n', '<leader>td', gs.toggle_deleted)

      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
})
