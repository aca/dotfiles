-- https://github.com/neovim/neovim/pull/16591
-- nvim_set_keymap('n', ' <NL>', '', {'nowait': v:true})

-- TODO: cleanup api, use vim.keymap.set? or nvim_set_keymap?

local nvim_set_keymap = vim.api.nvim_set_keymap
local set = vim.keymap.set
local vim = vim

-- general
set("n", ";;", ":")
set("v", ";;", ":")

-- zen, close all other windows
set("n", "<c-z>", ":cclose | :lclose<cr>")

-- refresh when fold
-- set("n", "zc", "zxzc", {})

-- switcher
set("n", "]q", ":cnext<cr>zz")
set("n", "[q", ":cprev<cr>zz")
set("n", "]l", ":lnext<cr>zz")
set("n", "[l", ":lprev<cr>zz")
set("n", "]b", ":bnext<cr>")
set("n", "[b", ":bprev<cr>")
set("n", "]t", ":tabn<cr>")
set("n", "[t", ":tabp<cr>")
set("n", "]w", "<c-w>w")
set("n", "[w", "<c-w>W")
set("n", "[j", "g;")
set("n", "]j", "g,")

set("n", ";n", ":set number!<CR>", { silent = true, noremap = true })

-- toggle
nvim_set_keymap("n", ";w", ":set wrap!<CR>", { silent = true, noremap = true })
-- nvim_set_keymap("n", ";n", ":set relativenumber! | set number!<CR>", { silent = true, noremap = true })
-- nvim_set_keymap("n", ";m", ":Messages<cr><c-w><c-w>", { silent = true, noremap = true })
-- nvim_set_keymap("n", ";m", ":Messages<cr><c-w><c-w>", { silent = true, noremap = true })
nvim_set_keymap("n", ";m", ":messages<cr>", { noremap = true })
nvim_set_keymap("n", "<leader>r", ":source<cr>", { noremap = true })
-- nvim_set_keymap("n", ";m", ":Redir messages<cr>", { noremap = true })
nvim_set_keymap("n", ";d", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true, noremap = true })

-- LSP
--
set("n", ";dd", vim.diagnostic.setloclist)
set("n", "gd", vim.lsp.buf.definition, { silent = true })
set("n", "gD", function()
	vim.cmd.vsplit()
	vim.lsp.buf.definition()
end, { silent = true })
-- set("n", "gv", function() vim.cmd.vsplit(); vim.lsp.buf.definition() end , { silent = true })

set("n", "gt", vim.lsp.buf.type_definition, { silent = true })
set("n", "[d", function()
	vim.diagnostic.goto_prev({ wrap = false })
end, { silent = true })
set("n", "]d", function()
	vim.diagnostic.goto_next({ wrap = false })
end, { silent = true })
-- NOTES: this is set by neovim, lsprestart fails if it's set here
-- set("n", "K", vim.lsp.buf.hover, { silent = true })
set("n", "<leader>gd", function()
	vim.cmd([[ vsplit ]])
	vim.lsp.buf.definition()
end, { silent = true })
set("n", "gi", vim.lsp.buf.implementation, { silent = true })
set({ "n", "v" }, ";a", function()
	vim.lsp.buf.code_action()
end)
set({ "n", "v" }, "<leader>q", function()
	vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor" } } })
end, { silent = true })

-- nvim_set_keymap("n", ";ff", "<cmd>Neoformat<CR>", { noremap = true, silent = true })
set("n", ";rn", vim.lsp.buf.rename, { silent = true })
set("n", ";rf", vim.lsp.buf.references, { silent = true })

-- https://github.com/yuki-yano/zero.nvim/blob/main/lua/zero.lua
nvim_set_keymap(
	"n",
	"0",
	"getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'",
	{ silent = true, noremap = true, expr = true }
)
nvim_set_keymap(
	"x",
	"0",
	"getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'",
	{ silent = true, noremap = true, expr = true }
)
nvim_set_keymap(
	"o",
	"0",
	"getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'",
	{ silent = true, noremap = true, expr = true }
)

vim.cmd([[
inoremap <c-c> <esc>
vnoremap <c-c> <esc>
vnoremap <expr> i mode()=~'\cv' ? 'i' : 'I'

nnoremap ;; :
vnoremap ;; :

" this makes p slow
" nnoremap <silent> pd            <cmd>lua vim.lsp.buf.peek_definition()<CR>

" imap <expr><C-j>                vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-j>'
imap <silent><expr>             <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'

nnoremap <silent> ;t :Neotest run<cr>

function! Togglesigncolumn()
  if &signcolumn == 'yes'
    let &signcolumn='no'
  else
    let &signcolumn='yes'
  endif
endfunction
" nnoremap <silent>;g :call Togglesigncolumn()\|Gitsigns toggle_signs<cr>
nnoremap <silent>;g :call Togglesigncolumn()<cr>

" nnoremap <silent>;s
"              \ : if exists("syntax_on") <BAR>
"              \    syntax off <BAR>
"              \ else <BAR>
"              \    syntax enable <BAR>
"              \ endif<CR>

function AerialToggle()
      AerialToggle
      wincmd p
endfunction
nnoremap <silent> ;s :call AerialToggle()<cr> 
" nnoremap <silent> ;t :AerialToggle <bar> wincmd p<cr>


" visual block increment
vnoremap <C-a> g<C-a>
vnoremap <C-x> g<C-x>
vnoremap g<C-a> <C-a>
vnoremap g<C-x> <C-x>
nnoremap <c-g> 2<c-g>

" mistakes
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Q1 q!
cnoreabbrev q1 q!
cnoreabbrev qq q!
cnoreabbrev ww w!
cnoreabbrev E e
cnoreabbrev Wq wq
cnoreabbrev Echo echo
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Qall qall
cnoreabbrev QA qa
cnoreabbrev Vs vs
cnoreabbrev VS vs
cnoreabbrev l lua
cnoreabbrev l= lua=

cnoreabbrev Source source
" cnoreabbrev src source
cnoreabbrev SOurce source

" qq to record, Q to replay
nnoremap Q @q
vnoremap Q :norm @q<cr>

" Split
nnoremap <leader>o :only<cr>

" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Clean search (highlight) -> replaced with no-hlsearch
" nnoremap <silent> <ESC> :<C-u>nohlsearch<CR> | echo
" nnoremap <silent><space><space> :noh <CR>

" vv, instead of V (which includes new line) + copy
nnoremap vv g^vg_"+ygv

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Save
" inoremap <silent><C-s>     <c-r>:write!<cr><cr>
nnoremap <silent><C-s>     :write!<cr><cr>

" https://github.com/mhinz/vim-galore/blob/master/README.md#saner-command-line-history
cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"
]])

vim.keymap.set("i", "<c-s>", function()
	if require("luasnip").expandable() then
		require("luasnip").expand()
	else
		vim.api.nvim_command("write")
	end
end, { remap = true, silent = true })
