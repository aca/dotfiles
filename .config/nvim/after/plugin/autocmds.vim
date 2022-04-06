" TODO: this will break `:Gina log`, cannot set syntax off for buffer only
" use treesitter highlight(disable others)
" autocmd FileType bash,c,c_sharp,clojure,cmake,comment,commonlisp,cpp,css,dockerfile,fennel,fish,go,gomod,graphql,hcl,html,java,javascript,jsdoc,json,jsonc,lua,vim,markdown syntax clear

" restore cursor position on start
autocmd BufReadPost * silent! exe "normal! g`\"" 

" set commentstring to '#' by default
autocmd BufWinEnter,BufAdd * if (&ft =="") | setlocal commentstring=#\ %s | endif

" zettels
autocmd BufNewFile ~/src/zk/**.md execute "0r! ~/src/configs/dotfiles/.config/nvim/templates/zettels.sh" . ' ' . expand('%:t:r')

" turn syntax off for long yaml
autocmd FileType yaml if line('$') > 500 | setlocal syntax=OFF | endif
