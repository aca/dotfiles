let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-s': 'split',
\ 'ctrl-v': 'vsplit'
\ }

" Rg without filename
command! -bang -nargs=* Rgg call fzf#vim#grep('rg --column --line-number --color=always --no-heading --line-number --smart-case -- 2>/dev/null '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4.. '}), 0)
command! -bang -nargs=* RggWithFile call fzf#vim#grep('rg --column --line-number --color=always --no-heading --line-number --smart-case -- 2>/dev/null '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 1.. '}), 0)

" https://github.com/junegunn/fzf/issues/1143
autocmd! FileType fzf
autocmd  FileType fzf setlocal laststatus=1 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" TODO: reset
" au FileType fzf tnoremap <buffer> <Esc> <c-c>
au FileType fzf tnoremap <buffer> <c-j> <c-j>
au FileType fzf tnoremap <buffer> <c-k> <c-k>

" let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }
let g:fzf_buffers_jump = 1 " [Buffers] Jump to the existing window if possible

" fzf mark with preview
function! s:fzfmarks() abort
  return call('fzf#vim#with_preview', [{'options': '--preview-window +{2}-/2', 'placeholder': '$([ -r $(echo {4} | sed "s#^~#$HOME#") ] && echo {4} || echo ' . fzf#shellescape(expand('%')) . '):{2}'}, 'up:50%', 'ctrl-/'])
endfunction
command! -bar -bang FZFMarks call fzf#vim#marks(s:fzfmarks(), 0)

nnoremap <silent><c-f>        :Rgg<cr>
nnoremap <silent><m-f>        :RggWithFile<cr>
nnoremap <silent><Leader>fw   :Rg <C-R><C-W><CR>
nnoremap <silent><Leader>fW   :Rg <C-R><C-A><CR>
vnoremap <silent><Leader>fw   y:Rg <C-R>"<CR>
nnoremap <silent><Leader>fm   :FZFMarks<cr>
nnoremap <silent><leader>fl   :BLines<cr>
nnoremap <silent><leader>ff   :Files<cr>
" nnoremap <silent><leader>ff   :lua require('telescope.builtin').find_files({layout_config={width=0.9}})<cr>
" nnoremap <silent><Leader>ff   :lua require'telescope.builtin'.find_files(require('telescope.themes').get_ivy())<cr>
nnoremap <silent><leader>fh   :History<CR>
nnoremap <silent><leader>'    :FZFMarks<cr>
nnoremap <silent><leader>b    :Buffers<cr>
nnoremap <silent><leader>fC   :Colors<cr>
nnoremap <silent><leader>fc   :Commits<cr>

packadd fzf
packadd fzf.vim
