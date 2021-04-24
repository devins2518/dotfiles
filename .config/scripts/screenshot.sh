#!/bin/sh
# syntax screenshot.sh local fullscreen

if [ $1 == "1" ]; then
    if [ $2 == "1" ]; then
        gnome-screenshot
    else
        sleep 1
        gnome-screenshot -a
    fi
    # Add input file -i
    notify-send -t 2000 "Screenshot taken!"
    exit 0
else
    if [ $2 == "1" ]; then
        gnome-screenshot -f /tmp/screenshot.png
    else
        gnome-screenshot -a -f /tmp/screenshot.png
    fi
fi
if [[ $? == 1 ]]; then exit 1; fi
notify-send -i /tmp/screenshot -t 2000 "Screenshot taken, uploading..."

# URL to uplaod to
url="https://shion.is-inside.me/upload"
# Authentication Key
authtoken="$(cat $HOME/.apikey)"
# Key name of the field to use authkey
formkey="key"
# JSON key to image URl
image="url"

curl --request POST -H "$formkey: $authtoken" -F "file=@/tmp/screenshot.png" $url | jq -r ".$image" | xclip -selection clipboard
notify-send -i /tmp/screenshot.png "Screenshot uploaded!"
rm /tmp/screenshot.png
