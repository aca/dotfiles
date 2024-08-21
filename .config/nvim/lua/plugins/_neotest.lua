if not pcall(require, "nvim-treesitter") then
	return
end

vim.cmd([[
packadd nvim-nio
packadd plenary.nvim
packadd neotest
packadd neotest-go
]])

require("neotest").setup({
	adapters = {
		require("neotest-go")({
			experimental = {
				test_table = true,
			},
			args = { "-count=1", "-timeout=60s", "-v" },
			-- config = function()
			-- 	-- get neotest namespace (api call creates or returns namespace)
			-- 	local neotest_ns = vim.api.nvim_create_namespace("neotest")
			-- 	vim.diagnostic.config({
			-- 		virtual_text = {
			-- 			format = function(diagnostic)
			-- 				local message =
			-- 					diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
			-- 				return message
			-- 			end,
			-- 		},
			-- 	}, neotest_ns)
			-- 	require("neotest").setup({
			-- 		-- your neotest config here
			-- 		adapters = {
			-- 			require("neotest-go"),
			-- 		},
			-- 	})
			-- end,
		}),
	},
    status = {
      enabled = true,
      signs = false,
      virtual_text = true
    },
})
