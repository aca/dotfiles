vim.cmd.packadd("autocomplete.nvim")

-- -- LSP signature help
require("autocomplete.signature").setup({
	border = nil, -- Signature help border style
	width = 80, -- Max width of signature window
	height = 25, -- Max height of signature window
	debounce_delay = 50,
})

-- buffer autocompletion with LSP and Tree-sitter
require("autocomplete.buffer").setup({
	border = nil, -- Documentation border style
	entry_mapper = nil, -- Custom completion entry mapper
	debounce_delay = 50,
})

-- https://gist.github.com/MariaSolOs/2e44a86f569323c478e5a078d0cf98cc

---Utility for keymap creation.
---@param lhs string
---@param rhs string|function
---@param opts string|table
---@param mode? string|string[]
local function keymap(lhs, rhs, opts, mode)
	opts = type(opts) == "string" and { desc = opts }
		or vim.tbl_extend("error", opts --[[@as table]], { buffer = bufnr })
	mode = mode or "n"
	vim.keymap.set(mode, lhs, rhs, opts)
end

---For replacing certain <C-x>... keymaps.
---@param keys string
local function feedkeys(keys)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
end

---Is the completion menu open?
local function pumvisible()
	return tonumber(vim.fn.pumvisible()) ~= 0
end

-- Use <Tab> to accept a Copilot suggestion, navigate between snippet tabstops,
-- or select the next completion.
-- Do something similar with <S-Tab>.
keymap("<Tab>", function()
	if pumvisible() then
		feedkeys("<C-n>")
	elseif vim.snippet.active({ direction = 1 }) then
		vim.snippet.jump(1)
	else
		feedkeys("<Tab>")
	end
end, {}, { "i", "s" })
keymap("<S-Tab>", function()
	if pumvisible() then
		feedkeys("<C-p>")
	elseif vim.snippet.active({ direction = -1 }) then
		vim.snippet.jump(-1)
	else
		feedkeys("<S-Tab>")
	end
end, {}, { "i", "s" })

-- Inside a snippet, use backspace to remove the placeholder.
keymap("<BS>", "<C-o>s", {}, "s")

-- Use enter to accept completions.
keymap("<cr>", function()
    print("enter")
	return pumvisible() and "<C-y>" or "<cr>"
end, { expr = true }, "i")
