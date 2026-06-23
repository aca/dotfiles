function ffh -d 'history --merge; history "--show-time=%Y-%m-%d %H:%M:%S " | fzf --no-sort'
  history --merge; history "--show-time=%Y-%m-%d %H:%M:%S " | fzf --no-sort
end