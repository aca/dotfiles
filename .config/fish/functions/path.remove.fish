function path.remove
  if set -l ind (contains -i -- $argv[1] $PATH)
    echo $ind
    set -e PATH[$ind]
  else 
    echo "$argv[1] not found"
  end
end
