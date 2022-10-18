#!/bin/bash

setxkbmap -option "compose:caps"
# xmodmap -e "keycode 48 = Return"
# xmodmap -e "keycode 47 = BackSpace"

export STUFF=$HOME/.stuff
export CFGS=$HOME/.config
export PKGS=$HOME/.pkgs

# Change the Default Pass Directory
export PASSWORD_STORE_DIR=$HOME/.stuff/.password-store

# xrdb -merge ~/.dotf/configs/x11/.Xresources

if [[ "$HOSTNAME" = "archlinux-deskt" ]]; then
  # xrandr --output DisplayPort-0 --primary --mode 2560x1440 --pos 0x183 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --mode 1920x1080 --pos 2560x0 --rotate right --output DVI-D-0 --off
  xrandr --output DisplayPort-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --mode 1920x1080 --pos 2560x245 --rotate normal --output DVI-D-0 --off
fi

while true
do
    dwm
done
