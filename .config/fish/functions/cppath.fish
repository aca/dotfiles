function cppath --description 'realpath(argv) | pbcopy'
  set p ""
  if not set -q argv[1]
    set p (pwd)
  else
    set p $argv[1]
  end
  realpath $p | tr -d '\n' |sed "s#$HOME#~#"  | string escape | pbcopy
end

