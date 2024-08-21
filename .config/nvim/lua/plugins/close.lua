
-- https://www.reddit.com/r/neovim/comments/re07pk/close_neovim_if_last_buffer/
-- TODO: replace with lua
--
--
vim.cmd([[
packadd nvim-bufdel
function s:close()
  " let win_getid = getwininfo(win_getid())[0]
  " if win_getid['quickfix'] == 1
  "   cclose
  " elseif win_getid['loclist'] == 1
  "   lclose
  " " elseif len(getbufinfo({'buflisted':1})) > 1
  " "   echom ":BufDel"
  " "   :BufDel
  " else
  "   let tabinfo = gettabinfo()
  "   if len(tabinfo) == 1 && len(tabinfo[0].windows) == 1
  "       :quit
  "   else
  "       :close
  "   endif
  " end

    let tabinfo = gettabinfo()
    if len(tabinfo) == 1 && len(tabinfo[0].windows) == 1
        :quit
    else
        :close
    endif
endfunction
inoremap <silent><C-Q>     <esc>:call <sid>close()<cr>
nnoremap <silent><C-Q>     :call <sid>close()<cr>
vnoremap <silent><C-Q>     <esc>:call <sid>close()<cr>
]])
