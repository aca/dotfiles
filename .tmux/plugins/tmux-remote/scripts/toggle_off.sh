#!/usr/bin/env bash

tmux set -u prefix
tmux set -u key-table

# Restore the original status-left saved by toggle_on
saved="$(tmux show-option -gv @remote-saved-status-left 2>/dev/null)"
tmux set -g status-left "$saved"

tmux refresh-client -S
