function x -d 'zettels'

  # if [ (count $argv) -eq 0 ]
  #   $EDITOR ~/src/zettels
  # else
  #   bash -c "cd ~/src/zettels && $EDITOR \$(fd -t f -e md | fzf --query "$argv" -1)"
  # end

  bash -c "cd ~/src/zettels && $EDITOR \$(fd -t f -e md | fzf --query \"$argv\" -1)"

end