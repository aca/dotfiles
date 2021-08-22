function cppath --description 'realpath(argv) | pbcopy'
  if not set -q argv[1]
    realpath . | tr -d '\n' | sed "s#$HOME#~#" | pbcopy
  else
    realpath "$argv[1]" | tr -d '\n' |sed "s#$HOME#~#"  | pbcopy
  end
end

