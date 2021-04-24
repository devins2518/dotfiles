#!/bin/sh

FILE=/tmp/screencap.lock

if test -f "$FILE"; then
    kill $(head -n 1 $FILE)
    rm $FILE
    notify-send "Recording ended"
    ffmpeg -y -i $HOME/Pictures/in.mp4 -an $HOME/Pictures/out.mp4
    rm $HOME/Pictures/in.mp4
    notify-send "Compressed video"
else
    ffmpeg -f x11grab -y -r 30 -s 1920x1080 -i :0.0 -c:v h264_nvenc $HOME/Pictures/in.mp4 & echo $! > $FILE
    notify-send "Recording started"
fi
