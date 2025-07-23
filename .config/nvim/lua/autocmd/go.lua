-- function _G.getcodeactions()
-- 	local params = vim.lsp.util.make_range_params()
--
-- 	params.context = {
-- 		triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
-- 		diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
-- 	}
--
-- 	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
-- 	for _, res in pairs(result or {}) do
-- 		for _, r in pairs(res.result or {}) do
-- 			vim.print(r)
-- 		end
-- 	end
-- end

local running_go_imports = true

vim.api.nvim_create_user_command("GoimportsDisable", function(msg)
	running_go_imports = true
end, {})
vim.api.nvim_create_user_command("GoimportsEnable", function(msg)
	running_go_imports = false
end, {})
vim.api.nvim_create_user_command("GoimportsStatus", function(msg)
	print(running_go_imports)
end, {})

-- require('plenary.nvim')

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	pattern = { "*.go" },
	callback = function()
		if running_go_imports then
			-- log.debug("Organize Imports skipped")
			return
		end
		local params = vim.lsp.util.make_range_params(0, "utf-16")
		-- params.context = { only = { "source.organizeImports" } } -- not sure this works
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.kind == "source.organizeImports" then
					running_go_imports = true
					vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
					running_go_imports = false
					return
				end
			end
		end
	end,
})

-- vim.api.nvim_create_autocmd({ "BufLeave", "CursorHold", "CursorHoldI" }, {
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {

-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
-- 	pattern = { "*.go" },
-- 	callback = function()
-- 		for _, v in ipairs(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) do
-- 			-- Function to extract the last URL
-- 			if v["code"] == "NoNewVar" then
-- 				vim.cmd(":" .. v["lnum"] + 1 .. "s/:=/=/")
-- 				-- vim.lsp.buf.code_action({ apply = true, filter = function(action) return action.title == "Organize Imports" end })
-- 				-- return nil
-- 			end
-- 		end
-- 	end,
-- })

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

-- Auto apply Go import fixes on save
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*.go",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    
    -- Get current buffer diagnostics
    local diagnostics = vim.diagnostic.get(bufnr)
    
    -- Get attached clients using the new API
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if #clients == 0 then return end
    
    -- Create code action params with proper encoding
    local params = vim.lsp.util.make_range_params(0, clients[1].offset_encoding)
    params.context = {
      diagnostics = diagnostics,
      only = { "quickfix" }
    }
    
    -- Request code actions
    local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
    
    if not results then return end
    
    -- Process results from each LSP client
    for client_id, result in pairs(results) do
      local client = vim.lsp.get_client_by_id(client_id)
      
      if result.result and client then
        for _, action in ipairs(result.result) do
          -- Check if this is an import action
          if action.title and action.title:match("Add import") then
            -- Apply the code action
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
            elseif action.command then
              vim.lsp.buf.execute_command(action.command)
            end
          end
        end
      end
    end
  end,
})
