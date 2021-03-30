# diff (echo 3 | psub) (echo 4 | psub) -> diff.cmd "echo 3" "echo 4"
function diff.cmd -d 'diff.cmd "echo 3" "echo 4"'
  [ (count $argv) != 2 ] && return 1
  nvim -d ( fish -c $argv[1] | psub) ( fish -c $argv[2] |psub)
end
