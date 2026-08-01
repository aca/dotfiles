#!/usr/bin/env bash

  CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  source "$CURRENT_DIR/helpers/helpers.sh"

  # set custom indicator options before sourcing the plugin
  set_tmux_conf_helper<<-HERE
  set -g @remote-indicator-text " SSH "
  set -g @remote-indicator-fg "colour255"
  set -g @remote-indicator-bg "colour160"
  run-shell '~/.tmux/plugins/tmux-plugin-under-test/*.tmux'
HERE

  _clone_the_plugin

  tmux new -d

  # verify custom options are preserved (not overwritten by defaults)
  text="$(tmux show-option -gv @remote-indicator-text)"
  fg="$(tmux show-option -gv @remote-indicator-fg)"
  bg="$(tmux show-option -gv @remote-indicator-bg)"

  if [ "$text" != " SSH " ]; then
      fail_helper "Expected custom text ' SSH ', got '$text'"
  fi
  if [ "$fg" != "colour255" ]; then
      fail_helper "Expected custom fg 'colour255', got '$fg'"
  fi
  if [ "$bg" != "colour160" ]; then
      fail_helper "Expected custom bg 'colour160', got '$bg'"
  fi

  exit_helper
