function cppath --description 'realpath(argv) | pbcopy'
  set p ""
  if not set -q argv[1]
    set p (pwd)
  else
    set p $argv[1]
  end
  realpath $p | tr -d '\n' | string escape -n |  sed "s#$HOME#~#"  | pbcopy
end

