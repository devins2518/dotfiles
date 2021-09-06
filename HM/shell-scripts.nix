{ pkgs, clipboard ? null, sstool ? null, selarg ? null, ... }:

rec {
  screenshot = pkgs.writeScriptBin "screenshot" ''
    #!/usr/bin/env bash
    #
    # syntax screenshot.sh local fullscreen

    if [ $1 == "1" ]; then
        filename=$HOME/Pictures/$(date "+%Y-%m-%d_%H%M%S")_${sstool}.png
        if [ $2 == "1" ]; then
            ${sstool} $filename
        else
            ${sstool} ${selarg} $filename
        fi
        notify-send -t 2000 "Screenshot taken!"
        exit 0
    else
        if [ $2 == "1" ]; then
            ${sstool} /tmp/screenshot.png
        else
            ${sstool} ${selarg} /tmp/screenshot.png
        fi
    fi
    if [[ $? == 1 ]]; then exit 1; fi
    notify-send -t 2000 "Screenshot taken, uploading..."

    # URL to uplaod to
    url="https://0x0.st"

    curl -F "file=@/tmp/screenshot.png" $url | ${clipboard}
    notify-send "Screenshot uploaded!"
    rm /tmp/screenshot.png
  '';

  autoclose = pkgs.writeScriptBin "autoclose" ''
    #!/usr/bin/env bash
    $@&
    read -r _ _ _ _ n < <(bspc subscribe -c 1 node_add)
    bspc node $n -f
    bspc subscribe -c 1 node_focus desktop_focus
    bspc node $n -c
  '';

  compilenote = pkgs.writeScriptBin "compilenote" ''
    #!/usr/bin/env bash

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
  airplane-mode = pkgs.writeScriptBin "airplane-mode" ''
    #!/usr/bin/env bash

    radio="$(nmcli radio all | awk 'FNR == 2 {print $2}')"

    if [ "$radio" = "enabled" ]
     then
        nmcli radio all off
        notify-send "Airplane mode enabled"
    else
        nmcli radio all on
        notify-send "Airplane mode disabled"
    fi

    if rfkill list bluetooth | grep -q 'yes$' ; then
        sudo rfkill unblock bluetooth
    else
        sudo rfkill block bluetooth
    fi
  '';
  cachix-push = pkgs.writeScriptBin "cachix-push" ''
    #!/usr/bin/env bash

    export CACHIX_AUTH_TOKEN=$(cat ~/.cachix_auth)

    nix path-info --all | cachix push devins2518
  '';
}
