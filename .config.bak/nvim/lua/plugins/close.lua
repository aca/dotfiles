
-- https://www.reddit.com/r/neovim/comments/re07pk/close_neovim_if_last_buffer/
-- TODO: replace with lua
--
--
vim.cmd([[
packadd nvim-bufdel
function s:close()
  if getwininfo(win_getid())[0]['quickfix'] == 1
    cclose
  elseif getwininfo(win_getid())[0]['loclist'] == 1
    lclose
  elseif len(getbufinfo({'buflisted':1})) > 1
    :BufDel
  else
    q!
  end
endfunction
inoremap <silent><C-Q>     <esc>:call <sid>close()<cr>
nnoremap <silent><C-Q>     :call <sid>close()<cr>
vnoremap <silent><C-Q>     <esc>:call <sid>close()<cr>
]])
