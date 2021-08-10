{ pkgs, ... }:

rec {
  home.packages = with pkgs; [ pamixer ];

  xdg.configFile."river/init".text = ''
    #!/usr/bin/env bash

    set -x

    riverctl spawn "wlr-randr --output eDP-1 --scale 2"
    riverctl spawn 'kile'
    riverctl spawn "paper -i /etc/wallpaper/wallpaper.png"

    # Use the "logo" key as the primary modifier
    mod="Mod4"

    riverctl map normal $mod Return spawn foot
    riverctl map normal $mod Space spawn "pkill wofi || wofi --show drun -I"
    riverctl map normal $mod E spawn pcmanfm
    riverctl map normal $mod Q close
    riverctl map normal $mod+Shift Q exit
    riverctl map normal $mod+Shift R spawn "/home/devin/.config/river/init"

    # Mod+J and Mod+K to focus the next/previous view in the layout stack
    riverctl map normal $mod J focus-view next
    riverctl map normal $mod K focus-view previous

    # Mod+Shift+J and Mod+Shift+K to swap the focused view with the next/previous
    # view in the layout stack
    riverctl map normal $mod+Shift J swap next
    riverctl map normal $mod+Shift K swap previous

    # Mod+Period and Mod+Comma to focus the next/previous output
    riverctl map normal $mod Period focus-output next
    riverctl map normal $mod Comma focus-output previous
    riverctl map normal $mod Tab focus-previous-tags

    # Mod+Shift+{Period,Comma} to send the focused view to the next/previous output
    riverctl map normal $mod+Shift Period send-to-output next
    riverctl map normal $mod+Shift Comma send-to-output previous

    # Mod+H and Mod+L to decrease/increase the main ratio of rivertile(1)
    riverctl map normal $mod H send-layout-cmd rivertile "main-ratio -0.05"
    riverctl map normal $mod L send-layout-cmd rivertile "main-ratio +0.05"
    riverctl map normal $mod Print spawn 'screenshot 0 0'
    riverctl map normal $mod+Shift Print spawn 'screenshot 1 0'
    riverctl map normal $mod+Control Print spawn 'screenshot 0 1'
    riverctl map normal $mod+Shift+Control Print spawn 'screenshot 1 1'

    # Mod+Shift+H and Mod+Shift+L to increment/decrement the main count of rivertile(1)
    riverctl map normal $mod+Shift H send-layout-cmd rivertile "main-count +1"
    riverctl map normal $mod+Shift L send-layout-cmd rivertile "main-count -1"

    # Mod+Alt+{H,J,K,L} to move views
    riverctl map normal $mod+Mod1 H move left 100
    riverctl map normal $mod+Mod1 J move down 100
    riverctl map normal $mod+Mod1 K move up 100
    riverctl map normal $mod+Mod1 L move right 100

    # Mod+Alt+Control+{H,J,K,L} to snap views to screen edges
    riverctl map normal $mod+Mod1+Control H snap left
    riverctl map normal $mod+Mod1+Control J snap down
    riverctl map normal $mod+Mod1+Control K snap up
    riverctl map normal $mod+Mod1+Control L snap right

    # Mod+Alt+Shif+{H,J,K,L} to resize views
    riverctl map normal $mod+Mod1+Shift H resize horizontal -100
    riverctl map normal $mod+Mod1+Shift J resize vertical 100
    riverctl map normal $mod+Mod1+Shift K resize vertical -100
    riverctl map normal $mod+Mod1+Shift L resize horizontal 100

    # Mod + Left Mouse Button to move views
    riverctl map-pointer normal $mod BTN_LEFT move-view

    # Mod + Right Mouse Button to resize views
    riverctl map-pointer normal $mod BTN_RIGHT resize-view

    for i in $(seq 1 9)
    do
        tags=$((1 << ($i - 1)))

        # Mod+[1-9] to focus tag [0-8]
        riverctl map normal $mod $i set-focused-tags $tags

        # Mod+Shift+[1-9] to tag focused view with tag [0-8]
        riverctl map normal $mod+Shift $i set-view-tags $tags

        # Mod+Ctrl+[1-9] to toggle focus of tag [0-8]
        riverctl map normal $mod+Control $i toggle-focused-tags $tags

        # Mod+Shift+Ctrl+[1-9] to toggle tag [0-8] of focused view
        riverctl map normal $mod+Shift+Control $i toggle-view-tags $tags
    done


    # Mod+0 to focus all tags
    # Mod+Shift+0 to tag focused view with all tags
    all_tags=$(((1 << 32) - 1))
    riverctl map normal $mod 0 set-focused-tags $all_tags
    riverctl map normal $mod+Shift 0 set-view-tags $all_tags

    # Mod+Space to toggle float
    # riverctl map normal $mod Space toggle-float

    # Mod+F to toggle fullscreen
    riverctl map normal $mod F toggle-fullscreen

    # Mod+{Up,Right,Down,Left} to change layout orientation
    riverctl map normal $mod Up    send-layout-cmd rivertile "main-location top"
    riverctl map normal $mod Right send-layout-cmd rivertile "main-location right"
    riverctl map normal $mod Down  send-layout-cmd rivertile "main-location bottom"
    riverctl map normal $mod Left  send-layout-cmd rivertile "main-location left"

    # Declare a passthrough mode. This mode has only a single mapping to return to
    # normal mode. This makes it useful for testing a nested wayland compositor
    riverctl declare-mode passthrough

    # Mod+F11 to enter passthrough mode
    riverctl map normal $mod F11 enter-mode passthrough

    # Mod+F11 to return to normal mode
    riverctl map passthrough $mod F11 enter-mode normal

    # Various media key mapping examples for both normal and locked mode which do
    # not have a modifier
    for mode in normal locked
    do
        # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
        riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
        riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5'
        riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute'

        # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
        riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
        riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
        riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
        riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

        # Control screen backlight brighness with light (https://github.com/haikarainen/light)
        riverctl map $mode None XF86MonBrightnessUp   spawn 'light -A 5'
        riverctl map $mode None XF86MonBrightnessDown spawn 'light -U 5'
    done

    # Set repeat rate
    riverctl set-repeat 50 300

    # Set app-ids of views which should float
    riverctl float-filter-add "float"
    riverctl float-filter-add "popup"

    # Set app-ids of views which should use client side decorations
    riverctl csd-filter-add "gedit"

    # Set and exec into the default layout generator, rivertile.
    # River will send the process group of the init executable SIGTERM on exit.
    riverctl default-layout rivertile
    riverctl spawn "rivertile"
  '';
  xdg.configFile."river/init".executable = true;

  xdg.configFile."river/layout" = {
    text = ''
      #!/usr/bin/env bash

      # Nested layouts (examples)

      # Horizontal split layout with stacking on the last area
      read -r ''' HORIZONTAL << EOM
      (
        { hor:
          ver
          (
            { ver: full deck }
            1 0.5
          )
        } 1 0.63
      )
      EOM

      # The classic centered master layout
      # https://media.discordapp.net/attachments/769673106842845194/780095998239834142/unknown.png
      # Bran - BlingCorp
      read -r -d ''' CENTERED << EOM
      (
        { ver:
          hor $HORIZONTAL hor
        } 1 0.5 1
      )
      EOM

      # A partial implementation of the dwindle layout
      # After 3 splits windows are stacked
      read -r -d ''' DWINDLE << EOM
      (
        { ver: hor $HORIZONTAL
        } 1 0.55
      )
      EOM

      # A layout meant for grouping a shit ton of windows
      read -r -d ''' GROUP << EOM
      (
        { ver:
          { hor: deck deck }
          $HORIZONTAL 
          { hor: deck deck }
        } 1 0.45 1
      )
      EOM

      # Looks like the ordinary master and stack layout when main_count is one
      # but when increased, the additional windows in the main area will be 
      # vertically aligned below the main window.
      read -r -d ''' STACK << EOM
      (
        { ver:
          (
            { hor: full ver }
            1 0.6 0
          )
          hor
        } 1 0.65 0
      )
      EOM

      # Like STACK except the main and slave areas are inverted
      read -r -d ''' RSTACK << EOM
      (
        { ver:
          hor
          (
            { hor: full ver }
            1 0.60 0
          )
        } 1 0.65 1
      )
      EOM

      # Splits the output area vertically in 2 areas.
      # The main area has a count of one and a horizontal layout.
      # Below the the top window in the slave area windows are stacked on
      # top of each others like a deck of cards.
      # Inspired by Stacktile - https://git.sr.ht/~leon_plickat/stacktile
      read -r -d ''' DECK << EOM
      (
        { ver:
          hor
          (
            { hor: full deck }
            1 0.65 0
          )
        } 1 0.65 0
      )
      EOM

      # Like DECK except the main and slave areas are inverted
      read -r -d ''' RDECK << EOM
      (
        { ver:
          (
            { hor: full deck }
            1 0.65 0
          )
          hor
        } 1 0.65 1
      )
      EOM
    '';
    executable = true;
  };
}
