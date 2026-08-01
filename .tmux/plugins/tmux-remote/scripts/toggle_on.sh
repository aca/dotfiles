#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/variables.sh"

# Save the current status-left so toggle_off can restore it (only once)
saved="$(tmux show-option -gv "$saved_status_left_option" 2>/dev/null)"
if [[ -z "$saved" ]]; then
    tmux set -g "$saved_status_left_option" "$(tmux show-option -gv status-left)"
fi

# Read indicator options
text="$(tmux show-option -gv "$indicator_text_option")"
fg="$(tmux show-option -gv "$indicator_fg_option")"
bg="$(tmux show-option -gv "$indicator_bg_option")"

tmux set prefix None
tmux set key-table off
tmux set -g status-left "#[fg=$fg,bg=$bg]$text#[bg=default] "
tmux if -F '#{pane_in_mode}' 'send-keys -X cancel'
tmux refresh-client -S
