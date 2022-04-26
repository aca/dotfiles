-- NOTES
-- nvim_set_keymap('n', ' <NL>', '', {'nowait': v:true})

local nvim_set_keymap = vim.api.nvim_set_keymap

-- general
nvim_set_keymap("n", ";;", ":", { noremap = true })
nvim_set_keymap("v", ";;", ":", { noremap = true })

-- switcher
nvim_set_keymap("n", "]q", ":cnext<cr>zz", { noremap = true })
nvim_set_keymap("n", "[q", ":cprev<cr>zz", { noremap = true })
nvim_set_keymap("n", "]l", ":lnext<cr>zz", { noremap = true })
nvim_set_keymap("n", "[l", ":lprev<cr>zz", { noremap = true })
nvim_set_keymap("n", "]b", ":bnext<cr>", { noremap = true })
nvim_set_keymap("n", "[b", ":bprev<cr>", { noremap = true })
nvim_set_keymap("n", "]t", ":tabn<cr>", { noremap = true })
nvim_set_keymap("n", "[t", ":tabp<cr>", { noremap = true })
nvim_set_keymap("n", "]w", "<c-w>w", { noremap = true })
nvim_set_keymap("n", "[w", "<c-w>W", { noremap = true })
nvim_set_keymap("n", "[j", "g;", { noremap = true })
nvim_set_keymap("n", "]j", "g,", { noremap = true })

nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({wrap = false})<cr>", { noremap = true })
nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next({wrap = false})<cr>", { noremap = true })

-- toggle
nvim_set_keymap("n", ";w", ":set wrap!<CR>", { silent = true, noremap = true })
nvim_set_keymap("n", ";n", ":set relativenumber! | set number!<CR>", { silent = true, noremap = true })
nvim_set_keymap("n", ";m", ":Messages<cr><c-w><c-w>", { silent = true, noremap = true })
nvim_set_keymap("n", ";d", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", { silent = true, noremap = true })

-- LSP
nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
nvim_set_keymap("n", "gD", "<cmd>vsplit<bar>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true }) -- NOTES: rarely implemented
nvim_set_keymap("n", "gi", "<cmd>vsplit<bar>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
nvim_set_keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true, silent = true })

nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

