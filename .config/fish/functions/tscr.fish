function tscr -d 'tsc $1 && node $1'
  set f $argv[1]
  tsc $f && node (basename $f .ts)".js"
end