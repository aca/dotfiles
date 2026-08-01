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

  # simulate toggle on
  bash ~/.tmux/plugins/tmux-plugin-under-test/scripts/toggle_on.sh

  toggled="$(tmux show-option -gv status-left)"
  if [ "$toggled" == "$original" ]; then
      fail_helper "status-left should change after toggle on"
  fi

  # simulate toggle off
  bash ~/.tmux/plugins/tmux-plugin-under-test/scripts/toggle_off.sh

  restored="$(tmux show-option -gv status-left)"
  if [ "$restored" != "$original" ]; then
      fail_helper "Expected status-left to be restored to '$original', got '$restored'"
  fi

  exit_helper
