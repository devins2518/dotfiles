{ pkgs, ... }:

rec {
  xdg.configFile."river/init".text = ''
    #!/usr/bin/env bash

    riverctl spawn 'kile'
    riverctl spawn 'midle 1080 "swaylock -f"'
    riverctl spawn 'wlr-randr --output eDP-1 --scale 2'

    # Sourcing layouts
    source ~/.config/river/layout

    # Wallpaper
    riverctl spawn "paper -i /etc/wallpaper/wallpaper.png"

    # Use the "logo" key as the primary modifier
    mod="Mod4"

    # Mod+Shift+Return to start an instance of foot (https://codeberg.org/dnkl/foot)
    riverctl map normal $mod Return spawn foot

    # Mod+Space Launch wofi -drun
    riverctl map normal $mod Space spawn "wofi --show run -I"

    # Screen lock
    # riverctl map normal $mod f1 spawn swaylock

    # Cursor behaviour
    riverctl focus-follows-cursor disabled

    # Mod+Q to close the focused view
    riverctl map normal $mod Q close

    # Mod+Shift+Q to exit river
    riverctl map normal $mod+Shift Q exit

    # Mod+E to open pcmanfm
    riverctl map normal $mod E spawn pcmanfm

    # Mod+C for wofi-emoji
    # riverctl map normal $mod E spawn ~/.local/bin/wofi-emoji

    # Mod+P for the layout switcher
    # riverctl map normal $mod P spawn ~/.local/bin/layout

    # Mod+B for Eww hub
    # riverctl map normal $mod B spawn "~/.local/bin/eww close hub || ~/.local/bin/eww open hub"

    # Mod+J and Mod+K to focus the next/previous view in the layout stack
    riverctl map normal $mod h focus-output left
    riverctl map normal $mod j focus-output down
    riverctl map normal $mod k focus-output up
    riverctl map normal $mod l focus-output right

    riverctl map normal $mod+Shift h send-to-output left
    riverctl map normal $mod+Shift j send-to-output down
    riverctl map normal $mod+Shift k send-to-output up
    riverctl map normal $mod+Shift l send-to-output right

    # Screenshot with Swappy
    # riverctl map normal None print spawn 'fish -c "slurpshot -g"'
    # riverctl map normal Shift print spawn 'grim - | swappy -f -'

    # Screen recording with wf-recorder
    # riverctl map normal $mod+Shift R spawn 'fish -c "slurpshot -wf"'

    # Mod+Shift+{Period,Comma} to send the focused view to the next/previous output
    # riverctl map normal $mod+Shift L spawn "riverctl send-to-output next; riverctl focus-output next"
    # riverctl map normal $mod+Shift H spawn "riverctl send-to-output previous; riverctl focus-output previous"

    # Declare a passthrough mode. This mode has only a single mapping to return to
    # normal mode. This makes it useful for testing a nested wayland compositor
    # riverctl declare-mode passthrough
    # riverctl declare-mode testing

    # Mod+Return to bump the focused view to the top of the layout stack, making
    # it the new master
    # riverctl map normal $mod+Shift Return zoom

    # Keybindings for kile
    for mode in "normal"
    do
      case "$mode" in
        normal)
          layout="kile"
          ;;
        *)
          layout="randy"
          ;;
      esac
      # Mod+H and Mod+L to decrease/increase the width of the master column by 5%
      riverctl map "''${mode}" $mod H mod-layout-value "''${layout}" fixed main_factor -0.05
      riverctl map "''${mode}" $mod L mod-layout-value "''${layout}" fixed main_factor 0.05

      # Mod+Shift+{K, L} to increment/decrement the number of master views in the layout
      riverctl map "''${mode}" $mod+Control K mod-layout-value "''${layout}" int main_amount 1
      riverctl map "''${mode}" $mod+Control J mod-layout-value "''${layout}" int main_amount -1

      # Mod+Shift+{K, L} to move the index of the main views in the layout
      riverctl map "''${mode}" Control+Mod1 K mod-layout-value "''${layout}" int main_index 1
      riverctl map "''${mode}" Control+Mod1 J mod-layout-value "''${layout}" int main_index -1

      # Mod+Alt+{J,K} to decrease/increase the view padding
      riverctl map "''${mode}" $mod+Mod1 J mod-layout-value "''${layout}" int view_padding -5
      riverctl map "''${mode}" $mod+Mod1 K mod-layout-value "''${layout}" int view_padding +5

      # Custom layouts
      riverctl map "''${mode}" $mod T set-layout-value "''${layout}" string focused "$DECK"
      riverctl map "''${mode}" $mod G set-layout-value "''${layout}" string focused "$STACK"
      riverctl map "''${mode}" $mod D set-layout-value "''${layout}" string focused "$DWINDLE"
      riverctl map "''${mode}" $mod Q set-layout-value "''${layout}" string focused "$CENTERED"
      riverctl map "''${mode}" $mod+Shift G set-layout-value "''${layout}" string focused "$RSTACK"
      riverctl map "''${mode}" $mod+Shift T set-layout-value "''${layout}" string focused "$RDECK"
    done

    # Declaring scratchpads and their keybinds
    for key in 1 2 3 4 Y U I
    do
      case "$key" in
        1|2|3|4)
          i=$key
          ;;
        Y)
          i=5
          ;;
        U)
          i=6
          ;;
        I)
          i=7
          ;;
      esac
      tagmask=$((1 << ($i - 1)))

      # Mod+{M, N, B} to focus tag [20-22]
      riverctl map normal $mod $key set-focused-tags $tagmask

      # Mod+Shift+{M, N, B} to tag focused view with tag [20-22]
      riverctl map normal $mod+Shift $key set-view-tags $tagmask

      # Mod+Ctrl+{M, N, B} to toggle focus of tag [20-22]
      riverctl map normal $mod+Control $key toggle-focused-tags $tagmask

      # Mod+Shift+Ctrl+{M, N, B} to toggle tag [20-22] of focused view
      riverctl map normal $mod+Mod1 $key toggle-view-tags $tagmask
    done

    # Mod+0 to focus all tags
    # Mod+Shift+0 to tag focused view with all tags
    all_tags_mask=$(((1 << 8) - 1))
    riverctl map normal $mod O set-focused-tags $all_tags_mask
    riverctl map normal $mod+Shift O set-view-tags $all_tags_mask

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

    # Mod+Space to toggle float
    riverctl map normal Mod1 Space toggle-float

    # Mod+F to toggle fullscreen
    riverctl map normal $mod F toggle-fullscreen

    # Mod+F11 to enter passthrough mode
    # riverctl map normal $mod F11 enter-mode passthrough

    # Mod+F11 to return to normal mode
    # riverctl map passthrough $mod F11 enter-mode normal
    # riverctl map testing $mod F10 enter-mode normal

    # Mod+F10 to enter testing mode
    # riverctl map normal $mod F10 enter-mode testing

    # Various media key mapping for both normal and locked mode
    for mode in normal locked
    do
        riverctl map "''${mode}" None XF86Eject             spawn eject -T
        riverctl map "''${mode}" None XF86AudioRaiseVolume  spawn ~/.local/bin/volume up
        riverctl map "''${mode}" None XF86AudioLowerVolume  spawn ~/.local/bin/volume down
        riverctl map "''${mode}" None XF86AudioMute         spawn ~/.config/eww/scripts/mute
        riverctl map "''${mode}" None XF86AudioMedia        spawn playerctl play-pause
        riverctl map "''${mode}" None XF86AudioPlay         spawn playerctl play-pause
        riverctl map "''${mode}" None XF86AudioPrev         spawn playerctl previous
        riverctl map "''${mode}" None XF86AudioNext         spawn playerctl next
        riverctl map "''${mode}" None XF86MonBrightnessUp   spawn light -A 5
        riverctl map "''${mode}" None XF86MonBrightnessDown spawn light -U 5
    done

    # Set repeat rate
    riverctl set-repeat 50 300

    # Set app-ids of views which should float
    riverctl float-filter-add "float"
    riverctl float-filter-add "popup"
    riverctl float-filter-add "swappy"
    riverctl float-filter-add "imv"

    # Set app-ids of views which should use client side decorations
    riverctl csd-filter-add "swappy"

    # Set opacity and fade effect
    riverctl opacity 1.0 0.9 0.0 0.1 30

    # Border color focused
    riverctl border-color-focused '#6c5b53'

    # Border color focused
    riverctl border-color-unfocused '#464646'

    # Border width
    riverctl border-width 3

    # Default layout
    riverctl default-layout kile

    # Kile configuration
    for output in "eDP1"
    do
      riverctl set-layout-value kile int outer_padding 5
      case $output in
        eDP1)
          riverctl set-layout-value kile string all "$STACK"
          ;;
        HDMI-A-1)
          riverctl set-layout-value kile string all "$RDECK"
          ;;
      esac
      riverctl set-layout-value kile string 8 "$GROUP"
      riverctl attach-mode bottom
      riverctl focus-output next
    done
    riverctl focus-output next
  '';
  xdg.configFile."river/init".executable = true;

  xdg.configFile."river/layout".text = ''
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
  xdg.configFile."river/layout".executable = true;
}
