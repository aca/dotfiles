#!/usr/bin/env bash

  CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  source "$CURRENT_DIR/helpers/helpers.sh"

  install_tmux_plugin_under_test_helper

  tmux new -d

  # get default indicator options
  text="$(tmux show-option -gv @remote-indicator-text)"
  fg="$(tmux show-option -gv @remote-indicator-fg)"
  bg="$(tmux show-option -gv @remote-indicator-bg)"

  if [ "$text" == "" ]; then
      fail_helper "Default indicator text not set"
  fi
  if [ "$fg" == "" ]; then
      fail_helper "Default indicator fg not set"
  fi
  if [ "$bg" == "" ]; then
      fail_helper "Default indicator bg not set"
  fi

  # verify expected defaults
  if [ "$text" != " REMOTE >>>  " ]; then
      fail_helper "Expected default text ' REMOTE >>>  ', got '$text'"
  fi
  if [ "$fg" != "colour228" ]; then
      fail_helper "Expected default fg 'colour228', got '$fg'"
  fi
  if [ "$bg" != "colour52" ]; then
      fail_helper "Expected default bg 'colour52', got '$bg'"
  fi

  exit_helper
