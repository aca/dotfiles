#!/usr/bin/env sh

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc

sketchybar --add event input_change 'AppleSelectedInputSourcesChangedNotification' \
	--add item input right --set input script="$PLUGIN_DIR/input.sh" \
	icon=􀇳 \
	icon.font="$FONT:Black:13.0" \
	icon.color=$LOVE \
	icon.padding_left=10 \
	label.color=$LOVE \
	label.font="$FONT:Bold:13.0" \
	label.padding_right=10 \
	background.height=26 \
	background.color=$SURFACE \
	background.corner_radius=$CORNER_RADIUS \
	background.padding_right=5 \
	--subscribe input input_change
