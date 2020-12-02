#!/bin/sh

# Month from 1..12
# Used to determine season directory
month=$(date +%m)

while true; do
    # Hour 0..23
    hour=$(date +%H)
    # Night
    if [[ "$hour" -ge 0 ]] && [[ "$hour" -le 5 ]]; then
        current_seconds=$(date +%s)
        target_seconds=$(date -d '5:00' +%s)
        sleep_seconds=$(($target_seconds - $current_seconds))
        echo $sleep_seconds
        sleep $sleep_seconds
    # Early Morning
    elif [[ "$hour" -gt 5 ]] && [[ "$hour" -le 7 ]]; then
        current_seconds=$(date +%s)
        target_seconds=$(date -d '07:00' +%s)
        sleep_seconds=$(($target_seconds - $current_seconds))
        echo $sleep_seconds
        sleep $sleep_seconds
    # Morning
    elif [[ "$hour" -gt 7 ]] && [[ "$hour" -le 10 ]]; then
        current_seconds=$(date +%s)
        target_seconds=$(date -d '10:00' +%s)
        sleep_seconds=$(($target_seconds - $current_seconds))
        echo $sleep_seconds
        sleep $sleep_seconds
    # Noon
    elif [[ "$hour" -gt 10 ]] && [[ "$hour" -le 14 ]]; then
        current_seconds=$(date +%s)
        target_seconds=$(date -d '14:00' +%s)
        sleep_seconds=$(($target_seconds - $current_seconds))
        echo $sleep_seconds
        sleep $sleep_seconds
    # Afternoon
    elif [[ "$hour" -gt 14 ]] && [[ "$hour" -le 18 ]]; then
        current_seconds=$(date +%s)
        target_seconds=$(date -d '18:00' +%s)
        sleep_seconds=$(($target_seconds - $current_seconds))
        echo $sleep_seconds
        sleep $sleep_seconds
    # Night
    elif [[ "$hour" -gt 18 ]] && [[ "$hour" -le 23 ]]; then
        current_seconds=$(date +%s)
        target_seconds=$(date -d '23:59' +%s)
        sleep_seconds=$(($target_seconds - $current_seconds))
        echo $sleep_seconds
        sleep 1
        sleep $sleep_seconds
    fi
done
