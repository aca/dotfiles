function path.add
  if not set -q argv[1]
    set path (pwd)
  else
    set path $argv[1]
  end

  if [ -d "$path" ]
    # if set -l idx (contains -i  "$path" $PATH)
    #   set -e PATH[$idx]
    # end
    set -px PATH $path
  end
end
