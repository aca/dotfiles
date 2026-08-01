-- NOTES(aca): this lag on large file
-- https://www.reddit.com/r/neovim/comments/1ct2w2h/lua_adaptation_of_vimcool_auto_nohlsearch/
-- vim.api.nvim_create_autocmd('CursorMoved', {
--   group = vim.api.nvim_create_augroup('auto-hlsearch', { clear = true }),
--   callback = function ()
--     if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
--       vim.schedule(function () vim.cmd.nohlsearch() end)
--     end
--   end
-- })

-- mkdir on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		local dir = vim.fn.expand("%:p:h")
		local match = string.find(dir, "://")
		if match ~= nil then
			return
		end
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

-- if there's no other window but quickfix close vim
vim.api.nvim_create_autocmd("WinEnter", {
	-- group = group,
	pattern = { "*" },
	command = 'au WinEnter * if winnr(\'$\') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif',
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "" then
			vim.cmd("filetype detect")
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "elvish", "elv" },
	callback = function(ev)
		vim.bo.commentstring = "# %s"
		-- vim.bo[ev.buf].commentstring = "# %s"
		-- vim.bo[ev.buf].commentstring = "# %s"
	end,
})


  local hlgroup = vim.api.nvim_create_augroup("vimrc-incsearch-highlight", { clear = true })

  vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = hlgroup,
    pattern = { "/", "?" },
    callback = function()
      vim.opt.hlsearch = true
    end,
  })

  vim.api.nvim_create_autocmd("CmdlineLeave", {
    group = hlgroup,
    pattern = { "/", "?" },
    callback = function()
      vim.opt.hlsearch = false
    end,
  })
