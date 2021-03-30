function cra
  [ -z $argv[1] ] && echo "argument" && return 1
  cp -rvp $HOME/src/github.com/aca/boilerplate/cra $argv[1]
end
