local function filetype()
    -- https://neovim.discourse.group/t/introducing-filetype-lua-and-a-call-for-help/1806#how-do-i-use-it-2
    --
    -- vim.filetype.add({
    --     pattern = {
    --         [".*"] = function(path, bufnr)
    --             local firstline = vim.api.nvim_buf_get_lines(bufnr, 0, 1, 0)[1]
    --             if firstline:match("#!/usr/bin/env") then
    --                 local v, _ = string.gsub(firstline, "#!/usr/bin/env ", "")
    --                 return v
    --             end
    --         end,
    --     },
    -- })
end
