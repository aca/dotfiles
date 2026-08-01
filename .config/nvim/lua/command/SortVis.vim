" Sort by selected(visual) column, by Gavin Freeborn
"
" | rr  |  Cool |
" | ref |  1100 |
" | rgf |     1 |
" | efw |  1200 |
" | efa |  1600 |
" VisualBlock [1, 1200, 1000, 1600] and :'<,'>SortVis
function! s:VisSort(isnmbr) range abort
	if visualmode() !=# "\<c-v>"
		execute 'silent! '.a:firstline.','.a:lastline.'sort i'
		return
	endif
	let firstline = line("'<")
	let lastline  = line("'>")
	let keeprega  = @a
	execute 'silent normal! gv"ay'
	execute "'<,'>s/^/@@@/"
	execute "silent! keepjumps normal! '<0\"aP"
	if a:isnmbr
		execute "silent! '<,'>s/^\s\+/\=substitute(submatch(0),' ','0','g')/"
	endif
	execute "sil! keepj '<,'>sort i"
	execute 'sil! keepj '.firstline.','.lastline.'s/^.\{-}@@@//'
	let @a = keeprega
endfunction
command! -range -nargs=0 -bang SortVis sil! keepj <line1>,<line2>call s:VisSort(<bang>0)
xmap s :SortVis<CR>
