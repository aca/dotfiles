function tmux.save -d "save tmux buffers"
  tmux capture-pane -pJ -S - -E -
end
