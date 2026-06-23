command! -buffer CloseTopWindow lua require"csvtools".CloseWindow()
command! -buffer TopWindow lua require"csvtools".NewWindow()
autocmd! InsertEnter *.csv,*.bat,*.tsv,*.tab lua require"csvtools".deleteMark()
autocmd! InsertLeave *.csv,*.bat,*.tsv,*.tab lua require"csvtools".Highlight()
