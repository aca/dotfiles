" https://vi.stackexchange.com/questions/8378/dump-the-output-of-internal-vim-command-into-buffer
" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
" :Redir hi | Show full output of command :!ls -al in scratch window:
" :Redir !ls -al | Shell output
function! Redir(cmd, rng, start, end)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let cmd = a:cmd =~' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
		if a:rng == 0
			let output = systemlist(cmd)
		else
			let joined_lines = join(getline(a:start, a:end), '\n')
			let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
			let output = systemlist(cmd . " <<< $" . cleaned_lines)
		endif
	else
		redir => output
		execute a:cmd
		redir END
		let output = split(output, "\n")
	endif
	new
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, output)
endfunction
command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

" :Chomp | remove trailing whitespaces
command! Chomp call _utils#chomp()

" :EX | chmod +x current buffer
command! EX call _utils#ex()

" :Highlight | find highlight in current context
command! Highlight call _utils#highlight()

" :Root | Change directory to the root of the Git repository
command! Root call _utils#root()

" :CD | cd to current buffer located
command! CD call _utils#cd()

" :NextFile | open next file in 'ls | sort'
command! NextFile :lua require'_utils'.open_nextfile()

" :PrevFile | open previous file in 'ls | sort'
command! PrevFile :lua require'_utils'.open_prevfile()

" :DelMarksAll | clear all marks
command! DelMarksAll :delm! | delm A-Z0-9

" :DiffOrig | Diff with disk
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Sort by selected(visual) column, by Gavin Freeborn
"
" | rr  |  Cool |
" | rgf |     1 |
" | efw |  1200 |
" | ref |  1000 |
" | efa |  1600 |
"
" VisualBlock [1, 1200, 1000, 1600] and :'<,'>SortVis
"
command! -range -nargs=0 -bang SortVis sil! keepj <line1>,<line2>call _utils#VisSort(<bang>0)
xmap s :SortVis<CR>

" :YankPath | copy current path in form of filename:linenr
command! YankPath :lua require'_utils'.yankpath()
nnoremap yp :YankPath<cr>
