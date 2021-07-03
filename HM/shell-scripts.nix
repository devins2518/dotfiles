{ pkgs, ... }:

rec {
  screenshot = pkgs.writeScriptBin "screenshot" ''
    #! /usr/bin/env bash
    #
    # syntax screenshot.sh local fullscreen

    if [ $1 == "1" ]; then
        if [ $2 == "1" ]; then
            maim $HOME/'Pictures/%Y-%m-%d_%H%M%S-$wx$h_maim.png'
        else
            maim -s $HOME/'Pictures/%Y-%m-%d_%H%M%S-$wx$h_maim.png'
        fi
        notify-send -t 2000 "Screenshot taken!"
        exit 0
    else
        if [ $2 == "1" ]; then
            maim /tmp/screenshot.png
        else
            maim -s /tmp/screenshot.png
        fi
    fi
    if [[ $? == 1 ]]; then exit 1; fi
    notify-send -t 2000 "Screenshot taken, uploading..."

    # URL to uplaod to
    url="https://0x0.st"
    # JSON key to image URl
    image="url"

    curl -F "file=@/tmp/screenshot.png" $url | xclip -selection clipboard
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
