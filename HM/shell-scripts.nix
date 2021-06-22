{ pkgs, ... }:

rec {
  screenshot = pkgs.writeScriptBin "screenshot" ''
    #! /usr/bin/env bash
    #
    # syntax screenshot.sh local fullscreen

    if [ $1 == "1" ]; then
        if [ $2 == "1" ]; then
            scrot $HOME/'Pictures/%Y-%m-%d_%H%M%S-$wx$h_scrot.png'
        else
            scrot -s $HOME/'Pictures/%Y-%m-%d_%H%M%S-$wx$h_scrot.png'
        fi
        notify-send -t 2000 "Screenshot taken!"
        exit 0
    else
        if [ $2 == "1" ]; then
            scrot /tmp/screenshot.png
        else
            scrot -s /tmp/screenshot.png
        fi
    fi
    if [[ $? == 1 ]]; then exit 1; fi
    notify-send -t 2000 "Screenshot taken, uploading..."

    # URL to uplaod to
    url="https://shion.is-inside.me/upload"
    # Authentication Key
    authtoken="$(cat $HOME/.apikey)"
    # Key name of the field to use authkey
    formkey="key"
    # JSON key to image URl
    image="url"

    curl --request POST -H "$formkey: $authtoken" -F "file=@/tmp/screenshot.png" $url | jq -r ".$image" | xclip -selection clipboard
    notify-send "Screenshot uploaded!"
    rm /tmp/screenshot.png
  '';

  autoclose = pkgs.writeScriptBin "autoclose" ''
    #! /usr/bin/env bash
    #! nix-shell -i bash -p pavucontrol
    $@&
    read -r _ _ _ _ n < <(bspc subscribe -c 1 node_add)
    bspc node $n -f
    bspc subscribe -c 1 node_focus desktop_focus
    bspc node $n -c
  '';

  compilenote = pkgs.writeScriptBin "compilenote" ''
    #! /usr/bin/env bash

    filename=$1
    target="/home/devin/Repos/notes/pdfs"
    outputFile="$(basename "$filename" .md).pdf"

    mkdir -p $target

    pandoc \
        --pdf-engine=xelatex \
        --wrap=auto \
        -f gfm \
        -V "geometry:left=3cm,right=3cm,top=2cm,bottom=2cm" \
        -o "$target/$outputFile" $filename
  '';
}
