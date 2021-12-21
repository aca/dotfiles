" :Highlight | find highlight in current context
command! Highlight echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')

