packadd fzf
packadd fzf.vim
packadd fugutive.vim

let g:fzf_action = {
\ 'ctrl-h': 'abort',
\ 'ctrl-l': 'abort',
\ 'ctrl-t': 'tab split',
\ 'ctrl-s': 'split',
\ 'ctrl-v': 'vsplit'
\ }

" https://github.com/junegunn/fzf/blob/master/README-VIM.md#hide-statusline
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=3 showmode ruler

" TODO: reset
" au FileType fzf tnoremap <buffer> <Esc> <c-c>
au FileType fzf tnoremap <buffer> <c-j> <c-j>
au FileType fzf tnoremap <buffer> <c-k> <c-k>

let g:fzf_preview_window = ['up:50%:border-bottom','ctrl-w']
" if exists('$TMUX')
"   let g:fzf_layout = { 'tmux': '-p90%,90%' }
" else
"   let g:fzf_layout = { 'window': { 'width': 0.99, 'height': 0.7 } }
" endif
let g:fzf_layout = { 'window': { 'width': 0.99, 'height': 0.9 } }
let g:fzf_buffers_jump = 1 " [Buffers] Jump to the existing window if possible

" fzf mark with preview
function! s:fzfmarks() abort
  return call('fzf#vim#with_preview', [{'options': '--preview-window +{2}-/2', 'placeholder': '$([ -r $(echo {4} | sed "s#^~#$HOME#") ] && echo {4} || echo ' . fzf#shellescape(expand('%')) . '):{2}'},'up:50%',  'ctrl-/'])
endfunction
command! -bar -bang FZFMarks call fzf#vim#marks(s:fzfmarks(), 0)

nnoremap <silent><m-f>        :RgWithFile<cr>
vnoremap <silent><c-f>        y:Rg <C-R>"<CR>
nnoremap <silent><c-f>        :Rg<cr>
nnoremap <silent><Leader>fw   :Rg <C-R><C-W><CR>

nnoremap <silent><Leader>fW   :Rg <C-R><C-A><CR>
vnoremap <silent><Leader>fw   y:Rg <C-R>"<CR>
nnoremap <silent><Leader>fm   :FZFMarks<cr>
nnoremap <silent><leader>fl   :BLines<cr>
nnoremap <silent><leader>ff   :Files<cr>
" nnoremap <silent><leader>ff   :lua require('telescope.builtin').find_files({layout_config={width=0.95}})<cr>
" nnoremap <silent><Leader>ff   :lua require'telescope.builtin'.find_files(require('telescope.themes').get_ivy())<cr>
" nnoremap <silent><c-f>        :lua require'telescope.builtin'.grep_string{ only_sort_text = true, search = '', {layout_config={width=0.95} }}<cr>
" nnoremap <silent><Leader>fw   :lua require('telescope.builtin').grep_string({layout_config={width=0.95}, search=''})<cr>


nnoremap <silent><leader>fh   :History<CR>
nnoremap <silent><leader>'    :FZFMarks<cr>
nnoremap <silent><leader>b    :Buffers<cr>
nnoremap <silent><leader>fC   :Colors<cr>
nnoremap <silent><leader>fc   :Commits<cr>

command! -bang -nargs=* Rg          call fzf#vim#grep('rg -L --line-number --color=always --no-heading  --smart-case -- 2>/dev/null '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 3.. '}), 0)
command! -bang -nargs=* RgWithFile  call fzf#vim#grep('rg -L --line-number --color=always --no-heading  --smart-case -- 2>/dev/null '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 1,3.. '}), 0)
