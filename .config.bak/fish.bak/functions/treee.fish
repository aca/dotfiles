function treee -d 'treee $level'
  set -l level 3
  if [ (count $argv) -eq 1 ]; set level $argv[1]; end
  exa -al --tree --level=$level
end