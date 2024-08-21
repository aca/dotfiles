packadd fzf
packadd fzf.vim

let g:fzf_action = {
\ 'ctrl-h': 'abort',
\ 'ctrl-l': 'abort',
\ 'ctrl-t': 'tab split',
\ 'ctrl-s': 'split',
\ 'ctrl-v': 'vsplit'
\ }

" https://github.com/junegunn/fzf/blob/master/README-VIM.md#hide-statusline
" autocmd! FileType fzf
" autocmd  FileType fzf set laststatus=0 noshowmode noruler 
"   \| autocmd BufLeave <buffer> exec 'set laststatus=' . _laststatus . ' showmode ruler'

autocmd! FileType fzf
autocmd  FileType fzf let _laststatus=&laststatus | set laststatus=0
  \| autocmd BufLeave <buffer> exec 'set laststatus=' . _laststatus

" autocmd! FileType fzf
" autocmd  FileType fzf set noshowmode noruler
"   \| autocmd BufLeave <buffer> set showmode ruler

" TODO: reset
" au FileType fzf tnoremap <buffer> <Esc> <c-c>
au FileType fzf tnoremap <buffer> <c-j> <c-j>
au FileType fzf tnoremap <buffer> <c-k> <c-k>

let g:fzf_preview_window = ['right:50%:noborder','ctrl-w']
let g:fzf_layout = { 'window': { 'width': 0.99, 'height': 0.8, 'relative': v:true } }
" if exists('$TMUX')
"   let g:fzf_layout = { 'tmux': '-p90%,80%' }
" endif
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

nnoremap <silent><leader>fh   :History<CR>
nnoremap <silent><leader>'    :FZFMarks<cr>
nnoremap <silent><leader>b    :Buffers<cr>
nnoremap <silent><leader>fc   :Commits<cr>

" Rg: Search in files
" Rg! Rg + include filename
command! -bang -nargs=* Rg call fzf#vim#grep('rg -L --line-number --color=always --no-heading  --smart-case -- 2>/dev/null '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth ' .substitute('<bang>','!','1,', '') . '3.. '}), 0)
