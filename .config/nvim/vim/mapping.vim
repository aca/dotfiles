"
" https://vim.fandom.com/wiki/Unused_keys


imap <C-l> <esc>

nnoremap ;; :
vnoremap ;; :

"
" LSP
"
nnoremap <silent> gd            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD            <cmd>vsplit<bar>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gt            <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> pd            <cmd>lua vim.lsp.buf.peek_definition()<CR>
nnoremap <silent> g0            <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW            <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

nnoremap <silent> ]d            <cmd>lua vim.lsp.diagnostic.goto_next({wrap = false})<CR>
nnoremap <silent> [d            <cmd>lua vim.lsp.diagnostic.goto_prev({wrap = false})<CR>

nnoremap <silent> ;d            <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> ;dd           <cmd>lua vim.lsp.diagnostic.set_loclist()<cr>
nnoremap <silent> ;r            <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> ;n            <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ;a            <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <silent> ;a            <cmd>lua vim.lsp.buf.range_code_action()<CR>
nnoremap <silent> ;i            <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> ;f            <cmd>lua vim.lsp.buf.formatting()<cr>
" nnoremap <silent> ;f            <cmd>lua require("lsp_run_quickfix")()<cr>
" nnoremap <silent> ;f            <cmd>lua vim.lsp.buf.code_action('')<CR>
nnoremap <silent> ;ff            <cmd>Neoformat<cr>

imap <expr><C-j>                vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-j>'
imap <expr><Tab>                v:lua.tab_complete()
smap <expr><Tab>                v:lua.tab_complete()
imap <expr><S-Tab>              v:lua.s_tab_complete()
smap <expr><S-Tab>              v:lua.s_tab_complete()

"
" Toggle
"
nnoremap <expr>   <bslash>f &foldlevel ? 'zM' :'zR'
nnoremap <silent> <bslash>w :set wrap!<CR>
nnoremap <silent> <bslash>n :set relativenumber!<CR>
nnoremap <silent> <bslash>g :Gitsigns toggle_signs<cr>
nnoremap <silent> <bslash>s
             \ : if exists("syntax_on") <BAR>
             \    syntax off <BAR>
             \ else <BAR>
             \    syntax enable <BAR>
             \ endif<CR>

"
" misc
"
" " gf that works with vim-fetch
" - ~/src/ (directory)
" - ~/src (it sometimes does not open directory properly)
" ~/.config/nvim/init.vim:9^2 (cursor at ^)
nnoremap <silent>gf WBgF

" visual block increment
vnoremap <C-a> g<C-a>
vnoremap <C-x> g<C-x>
vnoremap g<C-a> <C-a>
vnoremap g<C-x> <C-x>
nnoremap <c-g> 2<c-g>


" mistakes
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev q1 q!
" cnoreabbrev E e
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Qall qall
cnoreabbrev QA qa
cnoreabbrev Vs vs
cnoreabbrev VS vs

" repeat last command
" noremap <leader>re @:<CR>

" qq to record, Q to replay
nnoremap Q @q
vnoremap Q :norm @q<cr>

nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
nnoremap ]w <c-w>w
nnoremap [w <c-w>W
nnoremap ]f :NextFile<cr>
nnoremap [f :PrevFile<cr>
nnoremap [j g;
nnoremap ]j g,
" diff change
" nnoremap [C :packadd vim-misc \| packadd vim-colorscheme-switcher \| :NextColorScheme<cr>
" nnoremap ]C :packadd vim-misc \| packadd vim-colorscheme-switcher \| :PrevColorScheme<cr>

" Split
nnoremap <leader>o :only<cr>
noremap  <Leader><leader><leader> :<C-u>split<CR>
noremap  <Leader>v :<C-u>vsplit<CR>
command! Fish terminal fish
" nnoremap <leader>s :botright 10sp<bar>  :Fish<cr>i
" noremap <Leader>h :vs<bar>:terminal fish<CR>i
" noremap <Leader>v :sp<bar>:terminal fish<CR>i

" Set working directory(pwd) to location where current file is located
" nnoremap <leader>. :lcd %:p:h<CR>

" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Clean search (highlight)
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>

" vv, instead of V (which includes new line) + copy
nnoremap vv g^vg_"+ygv

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" command! -nargs=* T split | terminal <args>
" command! -nargs=* VT vsplit | terminal <args>

" close window, or buffer, or exit
function s:close()
  if winnr('$') != 1 
    close
  elseif len(getbufinfo({'buflisted':1})) > 1
    bd!
  else
    q!
  endif
endfunction
inoremap <silent><C-Q>     <esc>:call <sid>close()<cr>
nnoremap <silent><C-Q>     :call <sid>close()<cr>
vnoremap <silent><C-Q>     <esc>:call <sid>close()<cr>

" Save
inoremap <C-s>     <esc>:update<cr>
nnoremap <C-s>     :update<cr>

" https://github.com/mhinz/vim-galore/blob/master/README.md#saner-command-line-history
cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"

" 0 goes to first https://github.com/yuki-yano/zero.nvim/blob/main/lua/zero.lua
lua vim.api.nvim_set_keymap('n', '0', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", {silent = true, noremap = true, expr = true})

" https://stackoverflow.com/questions/3760444/in-vim-is-there-a-way-to-set-very-magic-permanently-and-globally/23021259#23021259
" nnoremap / /\v
" vnoremap / /\v
" cnoremap %s/ %smagic/
" cnoremap \>s/ \>smagic/
" nnoremap :g/ :g/\v
" nnoremap :g// :g//
