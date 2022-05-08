"
" https://vim.fandom.com/wiki/Unused_keys
 
inoremap <c-c> <esc>
vnoremap <c-c> <esc>
vnoremap <expr> i mode()=~'\cv' ? 'i' : 'I'

" nnoremap ;; :
" vnoremap ;; :

" LSP
inoremap <silent> <c-x>         <C-\><C-O>lua print(require('cmp').visible())<cmd>
" this makes p slow
" nnoremap <silent> pd            <cmd>lua vim.lsp.buf.peek_definition()<CR>

nnoremap <silent> g0            <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW            <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

nnoremap <silent> ;dd           <cmd>lua vim.lsp.diagnostic.set_loclist()<cr>
nnoremap <silent> ;a            <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <silent> ;a            <cmd>lua vim.lsp.buf.range_code_action()<CR>

" imap <expr><C-j>                vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-j>'
imap <silent><expr>             <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>' 

function AerialToggle()
      AerialToggle
      wincmd p
endfunction
nnoremap <silent> ;t :call AerialToggle()<cr>
" nnoremap <silent> ;t :AerialToggle <bar> wincmd p<cr>

function! Togglesigncolumn()
  if &signcolumn == 'yes'
    let &signcolumn='no'
  else
    let &signcolumn='yes'
  endif
endfunction
" nnoremap <silent>;g :call Togglesigncolumn()\|Gitsigns toggle_signs<cr>
nnoremap <silent>;g :call Togglesigncolumn()<cr>

nnoremap <silent>;s
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
" nnoremap <silent>gf WBgF

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
" cnoreabbrev E e
cnoreabbrev Wq wq
cnoreabbrev Echo echo
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
cnoreabbrev l lua

" repeat last command
" noremap <leader>re @:<CR>

" qq to record, Q to replay
nnoremap Q @q
vnoremap Q :norm @q<cr>


" Split
nnoremap <leader>o :only<cr>
" noremap  <Leader>h :<C-u>split<CR>
" noremap  <Leader>v :<C-u>vsplit<CR>
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

" close window, or buffer, or exit
function s:close()
  if getwininfo(win_getid())[0]['quickfix'] == 1
    cclose
  elseif getwininfo(win_getid())[0]['loclist'] == 1
    lclose
  elseif len(getbufinfo({'buflisted':1})) > 1
    BufferClose!
  else
    q!
  end
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

" copy current path in form of filename:linenr
nnoremap yp :YankPath<cr>

nnoremap <leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>
