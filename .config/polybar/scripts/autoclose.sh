#!/bin/bash
$@&
read -r _ _ _ _ n < <(bspc subscribe -c 1 node_add)
bspc node $n -f
bspc subscribe -c 1 node_focus desktop_focus
bspc node $n -c
