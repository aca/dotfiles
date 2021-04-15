# edit .git/config
function gitcfg
  set -l gitconfig (git rev-parse --show-toplevel 2>/dev/null || echo ".")/.git/config
  if test -f $gitconfig
    $EDITOR $gitconfig
  else
    return 1
  end
end

