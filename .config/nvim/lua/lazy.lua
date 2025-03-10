LJ
.    6   9  9  B K  nohlsearchcmdvim�  6   9  9  	   X �6   9  9  B 9  	  X �6   9  3 B K   scheduleexact_matchsearchcountfnhlsearchvvim O   
-   9   9  B -   9  9  9  B K  �definitionbuflspvsplitcmd?   -   9   9  5 B K  � 	wrapgoto_prevdiagnostic?   -   9   9  5 B K  � 	wrapgoto_nextdiagnosticQ   
-   9   ' B -   9  9  9  B K  �definitionbuflsp vsplit cmd5   -   9   9  9  B K  �code_actionbuflsp�   -   9   9  9  5 5 5 ==B K  �context context 	only 	only   quickfixrefactorcode_actionbuflsp�   6   ' B 9  B    X�6   ' B 9  B X �-   9  9  ' B K  �
writenvim_commandapiexpandexpandableluasniprequire�# 	 s �6   9  9  ' 5 6  99' 5 B=3	 =
B 6  6  9= 6  6 ' B= 6   9  ' B 6   9  9  6  996   ' ' ' B ' ' ' B ' ' ' B ' ' ' B ' ' ' B ' '  '! B ' '" '# B ' '$ '% B ' '& '' B ' '( ') B ' '* '+ B ' ', '- B ' '. '/ B ' '0 '1 B ' '2 '3 B ' '4 '5 56 B  ' '7 '8 59 B  ' ': '; 5< B  ' '= '> 5? B ' '@ 9A9BB ' 'C 9D9E9F5G B ' 'H 3I 5J B ' 'K 9D9E9L5M B ' 'N 3O 5P B ' 'Q 3R 5S B ' 'T 3U 5V B ' 'W 9D9E9X5Y B 5Z '[ 3\ B 5] '^ 3_ 5` B ' 'a 9D9E9b5c B ' 'd 9D9E9e5f B  ' 'g 'h 5i B  'j 'g 'h 5k B  'l 'g 'h 5m B9'n B99'o 'p 3q 5r B2  �K   silent
remap 
<c-s>i�inoremap <c-c> <esc>
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
 	exprnoremapsilento 	exprnoremapsilentx 	exprnoremapsilent<getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^'0 silentreferences;rf silentrename;rn silent <leader>q  nv ;a  nv silentimplementationgi silent <leader>gd silent ]d silent [d silenttype_definitiongt silent gD silentdefinitionbuflspgdsetloclistdiagnostic;dd noremapsilent-<cmd>lua vim.diagnostic.open_float()<CR>;d noremap:Redir messages<cr>;m noremapsilent:set wrap!<CR>;w noremapsilent:set number!<CR>;ng,]jg;[j<c-w>W[w<c-w>w]w:tabp<cr>[t:tabn<cr>]t:bprev<cr>[b:bnext<cr>]b:lprev<cr>zz[l:lnext<cr>zz]l:cprev<cr>zz[q:cnext<cr>zz]q:cclose | :lclose<cr>
<c-z>v:;;nsetkeymapnvim_set_keymap  runtime! lua/core/fzf.vim cmdplenary.logrequirelog
printP_Gcallback 
group 
group callback  
clearauto-hlsearchnvim_create_augroupCursorMovednvim_create_autocmdapivim 