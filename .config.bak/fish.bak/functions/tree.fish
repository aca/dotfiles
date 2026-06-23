function tree -d 'tree $level'
  set -l level 3
  if [ (count $argv) -eq 1 ]; set level $argv[1]; end
  exa --tree --level=$level
end