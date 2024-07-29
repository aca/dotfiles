function take -d 'Create a directory and set CWD'
  [ (count $argv) != 1 ] && return
  mkdir -p $argv
  cd $argv
end
