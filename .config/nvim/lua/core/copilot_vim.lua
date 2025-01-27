local hostname = vim.uv.os_gethostname()

if hostname ~= "txxx-nix" and hostname ~= "home" then
	return
end

-- vim.cmd.packadd("llm.nvim")
-- local llm = require("llm")
-- llm.setup({
-- 	url = "https://api.deepseek.com/chat/completions",
-- 	model = "deepseek-chat",
-- 	api_type = "openai",
-- 	max_tokens = 4096,
-- 	temperature = 0.3,
-- 	top_p = 0.7,
-- 	-- prompt = "You are a helpful Chinese assistant.",
-- 	api_token = "sk-fc30eba000864a32bc8a4bd420100b97",
-- 	backend = "openai",
-- 	-- url = "https://api.deepseek.com/chat/completions", -- llm-ls uses "/v1/completions"
-- 	-- cf https://github.com/abetlen/llama-cpp-python?tab=readme-ov-file#openai-compatible-web-server
-- 	-- request_body = {
-- 	--   temperature = 0.2,
-- 	--   top_p = 0.95,
-- 	-- }
-- })

vim.cmd.packadd("minuet-ai.nvim")

require("minuet").setup({
	virtualtext = {
		-- Specify the filetypes to enable automatic virtual text completion,
		-- e.g., { 'python', 'lua' }. Note that you can still invoke manual
		-- completion even if the filetype is not on your auto_trigger_ft list.
		auto_trigger_ft = { "go", "python" },
	},
	keymap = {
		-- accept whole completion
		accept = "<c-i>",
		-- accept one line
		-- accept_line = "<A-a>",
		-- -- accept n lines (prompts for number)
		-- accept_n_lines = "<A-z>",
		-- -- Cycle to prev completion item, or manually invoke completion
		prev = "<c-[>",
		-- Cycle to next completion item, or manually invoke completion
		next = "<c-]>",
		-- dismiss = "<A-e>",
	},
	provider = "openai_compatible",
	provider_options = {
		openai_compatible = {
			api_key = "DEEPSEEK_API_KEY",
			end_point = "https://api.deepseek.com/chat/completions",
			name = "deepseek-chat",
			-- stream = false,
			model = "deepseek-chat",
			-- template = {
			-- 	prompt = "See [Prompt Section for default value]",
			-- 	suffix = "See [Prompt Section for default value]",
			-- },
			optional = {
				stop = nil,
				max_tokens = nil,
			},
		},
		openai_fim_compatible = {
			api_key = "DEEPSEEK_API_KEY",
			end_point = "https://api.deepseek.com/chat/completions",
			name = "deepseek-chat",
			-- stream = false,
			model = "deepseek-chat",
			-- template = {
			-- 	prompt = "See [Prompt Section for default value]",
			-- 	suffix = "See [Prompt Section for default value]",
			-- },
			optional = {
				stop = nil,
				max_tokens = nil,
			},
		},
	},
})

-- vim.g.copilot_no_tab_map = true
--
-- vim.keymap.set("i", "<C-F>", 'copilot#Accept("\\<CR>")', {
-- 	expr = true,
-- 	replace_keycodes = false,
-- })
--
-- vim.keymap.set("i", "<C-F>", "<Plug>(copilot-accept-line)")
--
-- vim.defer_fn(function()
-- 	vim.cmd.packadd("copilot.vim")
-- 	vim.cmd([[
--         call copilot#Init()
--     ]])
-- end, 100)
--
-- -- vim.cmd.packadd("supermaven-nvim")
-- -- require("supermaven-nvim").setup({
-- --   keymaps = {
-- --     accept_suggestion = "<C-f>",
-- --     -- clear_suggestion = "<C-]>",
-- --     -- accept_word = "<C-j>",
-- --   },
-- -- })
