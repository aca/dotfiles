function _clear
  set -q TMUX && tmux clear-history
  clear
  commandline -f force-repaint
end

