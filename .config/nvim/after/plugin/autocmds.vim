" /usr/local/share/nvim/runtime/filetype.vim
" use treesitter highlight(disable others)
" autocmd FileType bash,c,c_sharp,clojure,cmake,comment,commonlisp,cpp,css,dockerfile,fennel,fish,go,gomod,graphql,hcl,html,java,javascript,jsdoc,json,jsonc,lua,vim syntax off
autocmd FileType markdown syntax off

" au BufNewFile,BufFilePre,BufRead *.md,*.markdown set filetype=markdown.pandoc

au BufRead,BufNewFile *.rkt,*.rktl  setf scheme
au BufRead,BufNewFile *.fish        setf fish
au BufRead,BufNewFile *.tf,*.tfvars setf terraform
au BufRead,BufNewFile *.hcl         setf hcl
au BufRead,BufNewFile *.h           setf c

" make directory if not exists
autocmd BufWritePre * call s:Mkdir()
function s:Mkdir()
  let dir = expand('%:p:h')
  if dir =~ '://'
    return
  endif
  if !isdirectory(dir)
    call mkdir(dir, 'p')
  endif
endfunction

" restore cursor position on start
au BufReadPost * silent! exe "normal! g`\"" 

" set commentstring to '#' by default
au BufWinEnter,BufAdd * if (&ft =="") | setlocal commentstring=#\ %s | endif

" zettels
autocmd BufNewFile ~/src/zettels/**.md execute "0r! ~/src/configs/dotfiles/.config/nvim/templates/zettels.sh" . ' ' . expand('%:t:r')

" turn syntax off for long yaml
" autocmd FileType yaml if line('$') > 500 | setlocal syntax=OFF | endif
