#!/bin/bash
#
# low battery warning
#

BATTERY=/sys/class/power_supply/BAT1

REM=$(grep "POWER_SUPPLY_ENERGY_NOW" $BATTERY/uevent | awk -F= '{ print $2 }')
FULL=$(grep "POWER_SUPPLY_ENERGY_FULL=" $BATTERY/uevent | awk -F= '{ print $2 }')
PERCENT=$((REM * 100 / FULL))

if [ $PERCENT -le "15" ]; then
    notify-send "Low battery"
fi
