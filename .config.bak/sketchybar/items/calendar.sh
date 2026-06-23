#!/usr/bin/env sh

sketchybar --add item calendar right \
	--set calendar update_freq=15 \
	icon.color=$LOVE \
	icon.padding_left=10 \
	icon.font="$FONT:Bold:13.0" \
	label.color=$LOVE \
	label.font="$FONT:Bold:13.0" \
	label.padding_right=10 \
	script="$PLUGIN_DIR/calendar.sh" \
	background.height=26 \
	background.color=$SURFACE \
	background.corner_radius=$CORNER_RADIUS \
	background.padding_right=5
