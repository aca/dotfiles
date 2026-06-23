#!/usr/bin/env bash

# Save the current status-left so toggle_off can restore it
tmux set -g @remote-saved-status-left "$(tmux show-option -gv status-left)"

# Read indicator options
text="$(tmux show-option -gv @remote-indicator-text)"
fg="$(tmux show-option -gv @remote-indicator-fg)"
bg="$(tmux show-option -gv @remote-indicator-bg)"

tmux set prefix None
tmux set key-table off
tmux set -g status-left "#[fg=$fg,bg=$bg]$text#[bg=default] "
tmux if -F '#{pane_in_mode}' 'send-keys -X cancel'
tmux refresh-client -S
