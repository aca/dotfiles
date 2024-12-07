local vim = vim

vim.filetype.add({
	extension = {
		pc = "c",
		tyson = "typescript",
	},
	filename = {
		["justfile"] = "just",
	},
})
--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "go",
-- 	callback = function()
-- 		vim.bo.expandtab = false
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "markdown",
-- 	callback = function()
-- 		vim.o.textwidth = 80
-- 		vim.o.signcolumn = "no"
-- 	end,
-- })

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

vim.filetype.add({
	pattern = {
		[".*"] = {
			function(path, bufnr)
				local content = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
				if string.find(content, "#!/usr/bin/env") ~= nil then
                    if string.find(content, " deno") ~= nil then
                        return "typescript"
                    elseif string.find(content, " python") ~= nil then
                        return "python"
                    elseif string.find(content, " bun") ~= nil then
                        return "typescript"
                    elseif string.find(content, " elvish") ~= nil then
                        return "elvish"
                    elseif string.find(content, " fish") ~= nil then
                        return "fish"
                    end
				end
			end,
			{ priority = -math.huge },
		},
	},
})
