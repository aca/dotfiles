-- NOTES: move to null-ls
-- Organize Imports on save
--
local running_go_imports = false
vim.api.nvim_create_user_command("GoimportsDisable", function(msg)
	running_go_imports = true
end, {})
vim.api.nvim_create_user_command("GoimportsEnable", function(msg)
	running_go_imports = false
end, {})
vim.api.nvim_create_user_command("GoimportsPrint", function(msg)
	print(running_go_imports)
end, {})

-- require('plenary.nvim')

-- local running_go_imports_debouncer = vim.uv.new_timer()

vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave", "CursorHold", "CursorHoldI" }, {
	pattern = { "*.go" },
	callback = function()
		if running_go_imports then
            log.debug("Organize Imports skipped")
			return
		end
        -- running_go_imports_debouncer:start(500, 0, vim.schedule_wrap(function()
        --     vim.cmd("GoimportsEnable")
        -- end))
		-- this is async
		-- vim.lsp.buf.code_action({ apply = true, filter = function(action) return action.title == "Organize Imports" end })
		local params = vim.lsp.util.make_range_params()
		-- params.context = { only = { "source.organizeImports" } } -- not sure this works
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.kind == "source.organizeImports" then
                    log.debug("Organize Imports start")
                    running_go_imports = true
					vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
                    log.debug("Organize Imports done")
					running_go_imports = false
					return
				end
			end
		end
	end,
})

-- -- https://github.com/neovim/nvim-lspconfig/issues/115
-- vim.api.nvim_create_autocmd({"CursorHold"}, {
--     pattern = { "*.go" },
--     callback = function()
--         -- this runs in async
--         vim.lsp.buf.code_action({ apply = true, filter = function(action) return action.title == "Organize Imports" end })
--     end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "*.go",
--     callback = function()
--         vim.o.expandtab = false
--     end,
-- })
