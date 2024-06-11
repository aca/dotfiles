#!/usr/bin/env sh

sketchybar --add item clock right \
	--set clock update_freq=1 \
	icon.padding_left=10 \
	icon.color=$WHITE \
	icon.font="$FONT:Bold:13.0" \
	label.color=$WHITE \
	label.padding_right=5 \
	label.width=52 \
	label.font="$FONT:Bold:13.0" \
	align=center \
	script="$PLUGIN_DIR/clock.sh" \
	background.height=26 \
	background.color=$SURFACE \
	background.corner_radius=$CORNER_RADIUS \
	background.padding_right=2
