  #/usr/bin/env bash

  CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  # bash helpers provided by 'tmux-test'
  source $CURRENT_DIR/helpers/helpers.sh

  # installs plugin from current repo in Vagrant (or on Travis)
  install_tmux_plugin_under_test_helper

  # start tmux in background (plugin under test is sourced)
  tmux new -d

  # get default options
  toggle_key="$(tmux show-option -gv @remote-toggle-key)"
  on_key="$(tmux show-option -gv @remote-on-key)"
  off_key="$(tmux show-option -gv @remote-off-key)"

  if [ "$toggle_key" == "" ]; then
      fail_helper "Default toggle key not set"
  fi
  if [ "$on_key" == "" ]; then
      fail_helper "Default on key not set"
  fi
  if [ "$off_key" == "" ]; then
      fail_helper "Default off key not set"
  fi

  # sets the right script exit code ('tmux-test' helper)
  exit_helper
