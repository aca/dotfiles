#!/usr/bin/env bash

$HOME/src/github.com/tmux-plugins/tmux-battery/scripts/battery_percentage.sh | tr -d '%'
# if [ $percentage -lt 50 ]; then
#   echo -n " $percentage"%
# else
#   echo "wrong"
# fi

# upower -i /org/freedesktop/UPower/devices/battery_BAT0
