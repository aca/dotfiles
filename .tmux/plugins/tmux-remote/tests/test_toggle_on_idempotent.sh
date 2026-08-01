#!/usr/bin/env bash

  CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  source "$CURRENT_DIR/helpers/helpers.sh"

  # set a custom status-left before sourcing the plugin
  set_tmux_conf_helper<<-HERE
  set -g status-left " #S "
  run-shell '~/.tmux/plugins/tmux-plugin-under-test/*.tmux'
HERE

  _clone_the_plugin

  tmux new -d

  original="$(tmux show-option -gv status-left)"

  # simulate toggle on twice — the second call should not overwrite the saved value,
  # so toggle_off still restores to the true original
  bash ~/.tmux/plugins/tmux-plugin-under-test/scripts/toggle_on.sh
  bash ~/.tmux/plugins/tmux-plugin-under-test/scripts/toggle_on.sh

  # simulate toggle off
  bash ~/.tmux/plugins/tmux-plugin-under-test/scripts/toggle_off.sh

  restored="$(tmux show-option -gv status-left)"
  if [ "$restored" != "$original" ]; then
      fail_helper "Expected status-left to be restored to '$original' after double toggle-on + toggle-off, got '$restored'"
  fi

  exit_helper
