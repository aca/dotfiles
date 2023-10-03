vim.cmd([[ packadd go.nvim ]])

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("go").setup({
    lsp_inlay_hints = {
        enable = false,
    },
    luasnip = true,
    -- lsp_cfg = {
    --     capabilities = capabilities,
    -- }
})

-- vim.cmd.packadd "nvim-go"
-- require('go').setup({})
-- vim.cmd [[ runtime after/ftplugin/go.lua ]]

-- local config = require('go.config')
-- local output = require('go.output')
-- local util = require('go.util')

-- function go_iferr() 
--     local boff = vim.fn.wordcount().cursor_bytes
--     local cmd = ('iferr' .. ' -pos ' .. boff)
--     local data = vim.fn.systemlist(cmd, vim.fn.bufnr('%'))
--
--     if vim.v.shell_error ~= 0 then
--         -- output.show_error(
--         --     prefix,
--         --     'command ' .. cmd .. ' exited with code ' .. vim.v.shell_error
--         -- )
--         print("error", vim.v.shell_error)
--         return
--     end
--
--     local r, c = unpack(vim.api.nvim_win_get_cursor(0))
--     -- local pos = vim.fn.getcurpos()[2]
--     -- vim.fn.append(pos, data)
--     vim.api.nvim_buf_set_lines(0, r-1, r, true, data)
--     vim.cmd([[silent normal! kj=2jjjo]])
--     -- vim.fn.setpos('.', pos)
-- end
--
-- vim.api.nvim_create_user_command("GoIfErr", function()
--     go_iferr()
-- end, {})
