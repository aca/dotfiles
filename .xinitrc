#!/usr/bin/env bash

export SXHKD_SHELL=/usr/bin/sh

xrandr --dpi 192

# key
setxkbmap -option # reset all
# setxkbmap -option ctrl:nocaps
xmodmap ~/.Xmodmap
setxkbmap -option 'ctrl:rctrl_ralt'
xset r rate 220 20

# daemon
copyq &
dunst &
sxhkd &
pueue start &


# ADD it to /etc/environment
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS='@im=fcitx'
# export WINIT_UNIX_BACKEND=x11 # alacritty(sway)
fcitx5 &

# jetbrains
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
# wmname LG3D

xrdb -merge ~/.Xresources
xset s off # disale screen save blanking
xset -dpms # turn off dpms

# optimus-manager
xrandr --setprovideroutputsource modesetting NVIDIA-0 || true

# picom -b
systemctl --user import-environment DISPLAY PATH
autorandr default || xrandr --auto

fish -c notsodeep.load

# feh --bg-fill ~/Downloads/images/39428b58da0c76276ec27f1038331f19.jpg --bg-fill ~/Downloads/images/092ef4380dfd31515c342ad36395400a.png --bg-fill ~/Downloads/images/M3hqBT9x_o.jpg


xinput --set-prop "pointer:Razer Orochi V2" 'Coordinate Transformation Matrix' 1.0, 0, 0, 0, 1.0, 0, 0, 0, 2.5

xhost local:root

exec bspwm
