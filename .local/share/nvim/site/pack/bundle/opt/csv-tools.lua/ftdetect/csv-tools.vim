au BufRead,BufNewFile *.csv,*.dat,*.tsv,*.tab set filetype=csv
"au FIiletype csv autocmd CursorMoved csv lua require"csvtools".Highlight()
