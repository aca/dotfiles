#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/variables.sh"

tmux set -u prefix
tmux set -u key-table

# Restore the original status-left saved by toggle_on, then clear the saved value so
# the next toggle_on cycle saves the current status-left rather than the stale snapshot.
saved="$(tmux show-option -gv "$saved_status_left_option" 2>/dev/null)"
if [[ -n "$saved" ]]; then
    tmux set -g status-left "$saved"
fi
tmux set -gu "$saved_status_left_option"

tmux refresh-client -S
