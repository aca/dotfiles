
-- /usr/local/share/nvim/runtime/filetype.vim
vim.cmd [[
" use treesitter highlight(disable others)
autocmd FileType bash,c,c_sharp,clojure,cmake,comment,commonlisp,cpp,css,dockerfile,fennel,fish,go,gomod,graphql,hcl,html,java,javascript,jsdoc,json,jsonc,lua,vim syntax off

au BufRead,BufNewFile *.rkt,*.rktl  setf scheme
au BufRead,BufNewFile *.fish        setf fish
au BufRead,BufNewFile *.tf,*.tfvars setf terraform
au BufRead,BufNewFile *.hcl         setf hcl

" restore cursor position on start
au BufReadPost * silent! exe "normal! g`\"" 

" set commentstring to '#' by default
au BufWinEnter,BufAdd * if (&ft =="") | setlocal commentstring=#\ %s | endif
]]
