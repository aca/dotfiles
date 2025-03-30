vim.o.foldmethod = 'expr'
-- Default to treesitter folding
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- Prefer LSP folding if client supports it

vim.api.nvim_create_autocmd(‘LspDetach’, { command = ‘setl foldexpr<‘ })
