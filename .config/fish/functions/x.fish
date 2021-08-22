function x -d 'zettels'
  if test (count $argv) -eq 0
    bash -c "cd ~/src/zettels && $EDITOR \$(fd -t f -e md | fzf --ansi --preview='bat --style plain --color=always  {}')"
  else
    bash -c "cd ~/src/zettels && $EDITOR $argv.md"
  end
end