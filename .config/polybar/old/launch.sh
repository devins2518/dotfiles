#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

## Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

## Launch
polybar primary -c ~/.config/polybar/old/config.ini &
sleep 2 &&
polybar music -c ~/.config/polybar/old/config.ini &
polybar secondary -c ~/.config/polybar/old/config.ini &
polybar secondary-lvds -c ~/.config/polybar/old/config.ini &
