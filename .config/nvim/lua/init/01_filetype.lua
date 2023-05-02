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

-- vim.filetype.add({
--     pattern = {
--         [".*"] = function(path, bufnr)
--             -- local firstline = vim.api.nvim_buf_get_lines(bufnr, 0, 1, 0)[1]
--             -- if firstline:match("#!/usr/bin/env") then
--             --     local v, _ = string.gsub(firstline, "#!/usr/bin/env ", "")
--             --     return v
--             -- end
--         end,
--     },
-- })

 vim.filetype.add {
   pattern = {
     ['.*'] = {
       priority = -math.huge,
       function(path, bufnr)
         local content = vim.filetype.getlines(bufnr, 1)
         if vim.filetype.matchregex(content, [[env -S deno run]]) then
           return 'typescript'
         end
       end,
     },
   },
 }

-- vim.filetype.add {
--     pattern = {
--         ['.*'] = {
--           function(path, bufnr)
--             if vim.filetype.match({ contents = {'#!/usr/bin/env -S deno run -A'} }) then
--                 return 'typescript'
--             end
--           end,
--         },
--         ['*'] = {
--           function(path, bufnr)
--             if vim.filetype.match({ contents = {'#!/usr/bin/env -S deno run -A'} }) then
--                 return 'typescript'
--             end
--           end,
--         }
--     }
-- }

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
      vim.bo.expandtab = false
  end,
})
