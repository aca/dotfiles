local vim = vim
vim.loader.enable()

local load = function()
	vim.cmd([[ runtime! lua/core/fzf.vim ]])

	require("core.treesitter")
	require("core.keymap")
	require("core.luasnip")
	require("core.cmp")
    require("core.copilot_vim")
	require("core.lsp")
	require("core.tmux")
	require("core.misc")

	vim.cmd([[
        runtime! lua/plugins/*
        runtime! lua/command/*
        runtime! lua/autocmd/*
        runtime! local/*
        runtime! lua/dev/*
    ]])

	-- -- require("core.zettels")

	vim.defer_fn(function()
		-- prevent delay on startup
		vim.cmd([[ silent! helptags ALL ]])
	end, 200)
end

vim.defer_fn(load, 50)
-- load()
