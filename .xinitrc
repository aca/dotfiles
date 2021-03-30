#!/bin/sh

xrandr --dpi 96

# key
setxkbmap -option # reset all
# setxkbmap -option ctrl:nocaps
xmodmap ~/.Xmodmap
setxkbmap -option 'ctrl:rctrl_ralt'
xset r rate 150 20

# daemon
copyq &
dunst &
sxhkd &
pueue start &

# scripts
~/src/bin/notsodeep.load
~/src/bin/fish.cleanhistory

# ADD it to /etc/environment
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
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
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto


systemctl --user import-environment DISPLAY PATH
exec bspwm
