{ config, pkgs, ... }: {
  config = {

    home.file.".config/picom.conf".source = ./picom.conf;
    home.file.".config/dunst/dunstrc".source = ./dunstrc;

    home.file.".icons/default".source =
      "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors";

    home.file.".config/bspwm".source = ./bspwm;
    home.file.".config/bspwm".recursive = true;

    xresources.properties = { "Xcursor.size" = 32; };

    gtk.gtk2.extraConfig = "gtk-cursor-theme-size=32";

    gtk.gtk3.extraConfig = { "gtk-cursor-theme-size" = 32; };

    services.sxhkd = {
      enable = true;
      extraConfig = ''
        #
        # wm independent hotkeys
        #

        # terminal emulator
        super + Return
            alacritty

        # program launcher
        super + d
            rofi -show drun

        # Open rofi as root
        super + shift + d
            sudo rofi -show drun

        # make sxhkd reload its configuration files:
        super + Escape
            pkill -USR1 -x sxhkd

        super + e
            pcmanfm

        # Volume keys
        Audio{Raise,Lower}Volume
            amixer sset Master {1+,1-} unmute

        #
        # bspwm hotkeys
        #

        # Show help
        super + s
            $HOME/.config/rofi/help.sh

        # quit/restart bspwm
        super + shift + {q,r}
            bspc {quit,wm -r}

        # close and kill
        super + {_,shift + }q
            bspc node -{c,k}

        # alternate between the tiled and monocle layout
        super + m
            bspc desktop -l next

        # Picture in picture mode
        super + p
            bspc node --state \~floating
            xdotool getactivewindow windowsize 768 432 windowmove 0 648 

        # Change volume
        XF86Audio{Raise,Lower}Volume
            pactl -- set-sink-volume 0 {+,-}2%

        # lockscreen
        alt + shift + x
            betterlockscreen -l blur

        #
        # state/flags
        #

        # Change to tiled mode
        super + t
            bspc node -t tiled

        # Change to pseudo_tiled, floating, fullscreen mode
        super + shift + {t,s,f}
            bspc node -t {pseudo_tiled,floating,fullscreen}

        # set the node flags
        super + ctrl + {m,x,y,z}
            bspc node -g {marked,locked,sticky,private}

        # Hide window
        super + n
            $HOME/.config/bspwm/hide.sh

        #
        # focus/swap
        #

        # focus the node in the given direction
        super + {_,shift + }{h,j,k,l}
            bspc node -{f,s} {west,south,north,east}

        # focus the node for the given path jump
        super + {p,b,comma,period}
            bspc node -f @{parent,brother,first,second}

        # focus the next/previous window in the current desktop
        super + {_,shift + }c
            bspc node -f {next,prev}.local.!hidden.window

        # focus the next/previous desktop in the current monitor
        super + bracket{left,right}
            bspc desktop -f {prev,next}.local

        # focus the last node/desktop
        super + Tab
            bspc desktop -f last

        # focus the older or newer node in the focus history
        super + {o,i}
            bspc wm -h off; \
            bspc node {older,newer} -f; \
            bspc wm -h on

        # focus or send to the given desktop
        super + {_,shift + }{1-9,0}
            bspc {desktop -f,node -d} '^{1-9,10}'

        #
        # preselect
        #

        # preselect the direction
        super + ctrl + {h,j,k,l}
            bspc node -p {west,south,north,east}

        # preselect the ratio
        super + ctrl + {1-9}
            bspc node -o 0.{1-9}

        # cancel the preselection for the focused node
        super + ctrl + space
            bspc node -p cancel

        # cancel the preselection for the focused desktop
        super + ctrl + shift + space
            bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel

        #
        # move/resize
        #

        # expand a window by moving one of its side outward
        super + alt + {h,j,k,l}
            bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}

        # contract a window by moving one of its side inward
        super + alt + shift + {h,j,k,l}
            bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}

        # move a floating window
        super + {Left,Down,Up,Right}
            bspc node -v {-20 0,0 20,0 -20,20 0}

        # Print screen with selection and upload
        Print
            $HOME/.config/scripts/screenshot.sh 0 0

        # Print screen with selection, local
        shift + Print
            $HOME/.config/scripts/screenshot.sh 1 0

        # Print screen and upload
        control + Print
            $HOME/.config/scripts/screenshot.sh 0 1

        # Print screen local
        control + shift + Print
            $HOME/.config/scripts/screenshot.sh 1 1
      '';
    };

    home.file.".config/rofi".source = ./rofi;
    home.file.".config/rofi".recursive = true;

    home.file.".config/polybar".source = ./polybar;
    home.file.".config/polybar".recursive = true;
  };
}