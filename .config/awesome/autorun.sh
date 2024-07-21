#!/usr/bin/env bash

# background
feh --bg-fill ~/.config/backgrounds/debian-snail.jpg &

# compositor
picom --animations -b &

# Notifications
dunst &

# sxhkd
sxhkd -c ~/.config/sxhkd/sxhkdrc &

