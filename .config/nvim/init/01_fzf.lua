vim.cmd.packadd("fzf")
vim.cmd.packadd("fzf.vim")

if vim.env.TMUX then
	vim.g.fzf_layout = { tmux = "90%,70%" }
else
	-- vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
	vim.g.fzf_layout = {
		window = {
			width = 0.99,
			height = 0.8,
			relative = true,
		},
	}
end

-- vim.cmd([[ runtime! lua/core/fzf.vim ]])
-- FZF actions
vim.g.fzf_action = {
	["ctrl-h"] = "abort",
	["ctrl-l"] = "abort",
	["ctrl-t"] = "tab split",
	["ctrl-s"] = "split",
	["ctrl-v"] = "vsplit",
}

-- Autocommands for FZF
vim.api.nvim_create_autocmd("FileType", {
	pattern = "fzf",
	callback = function()
		-- Store laststatus and set to 0
		local laststatus = vim.opt.laststatus:get()
		vim.opt.laststatus = 0

		-- Restore laststatus when leaving buffer
		vim.api.nvim_create_autocmd("BufLeave", {
			buffer = 0,
			callback = function()
				vim.opt.laststatus = laststatus
			end,
		})
	end,
})

-- Terminal mappings for FZF
vim.api.nvim_create_autocmd("FileType", {
	pattern = "fzf",
	callback = function()
		vim.keymap.set("t", "<c-j>", "<c-j>", { buffer = true })
		vim.keymap.set("t", "<c-k>", "<c-k>", { buffer = true })
	end,
})

-- FZF settings
vim.g.fzf_preview_window = { "right:50%:noborder", "ctrl-w" }
vim.g.fzf_buffers_jump = 1 -- [Buffers] Jump to the existing window if possible

-- Key mappings
local opts = { silent = true }

vim.keymap.set("n", "<m-f>", ":RgWithFile<CR>", opts)
vim.keymap.set("v", "<c-f>", 'y:Rg <C-R>"<CR>', opts)
vim.keymap.set("n", "<c-f>", ":Rg<CR>", opts)
vim.keymap.set("n", "<leader>fw", ":Rg <C-R><C-W><CR>", opts)
vim.keymap.set("n", "<leader>fW", ":Rg <C-R><C-A><CR>", opts)
vim.keymap.set("v", "<leader>fw", 'y:Rg <C-R>"<CR>', opts)
vim.keymap.set("n", "<leader>fm", ":FZFMarks<CR>", opts)
vim.keymap.set("n", "<leader>fl", ":BLines<CR>", opts)
vim.keymap.set("n", "<leader>ff", ":Files<CR>", opts)
vim.keymap.set("n", "<leader>fh", ":History<CR>", opts)
vim.keymap.set("n", "<leader>'", ":FZFMarks<CR>", opts)
vim.keymap.set("n", "<leader>b", ":Buffers<CR>", opts)
vim.keymap.set("n", "<leader>fc", ":Commits<CR>", opts)

-- Rg command with live reload and mode switching
vim.api.nvim_create_user_command("Rg", function(opts)
	local query = opts.args
	local nth = opts.bang and "1,3.." or "3.."
	local rg_cmd = "rg -L --hidden --no-messages --line-number --color=always --no-heading --smart-case -- 2>/dev/null"

	local initial_cmd = rg_cmd .. " " .. vim.fn.shellescape(query)

	local preview_opts = {
		options = {
			"--info=inline-right",
			"--prompt",
			"λ ",
			"--nth",
			nth,
			"--delimiter",
			":",
			"--bind",
			"change:reload:" .. rg_cmd .. " {q} || true",
			"--bind",
			"start:unbind(change)",
			"--bind",
			'ctrl-r:transform:[[ $FZF_PROMPT =~ regex ]] && echo "unbind(change)+change-prompt(λ )+enable-search+reload('
				.. rg_cmd
				.. " '' || true)\" || echo 'rebind(change)+change-prompt(λ [regex] )+disable-search+reload("
				.. rg_cmd
				.. " {q} || true)'",
			"--border-label-pos",
			"bottom",
			"--border-label",
			" ctrl-r: toggle fuzzy/regex ",
		},
	}

	local preview = vim.fn["fzf#vim#with_preview"](preview_opts)
	vim.fn["fzf#vim#grep"](initial_cmd, 1, preview, 0)
end, { bang = true, nargs = "*" })
