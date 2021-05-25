#!/bin/sh

hidden=$(bspc query -N -n .hidden -d focused)

bspc node "$hidden" -g hidden=off
