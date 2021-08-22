complete -c z -f -a '(_z_complete)'
complete -c z -s 'r' -d 'cd to highest ranked dir matching'
complete -c z -s 'i' -d 'cd with interactive selection'
complete -c z -s 'I' -d 'cd with interactive selection using fzf'
complete -c z -s 't' -d 'cd to most recently accessed dir matching'
complete -c z -s 'l' -d 'list matches instead of cd'
complete -c z -s 'c' -d 'restrict matches to subdirs of $PWD'
complete -c z -s 'e' -d 'echo the best match, don''t cd'
complete -c z -s 'b' -d 'jump backwards to given dir or to project root'
complete -c z -s 'x' -x -d 'remove path from history' -a '(_z_complete)'
function _z_complete
	eval z --complete (commandline -t)
end
