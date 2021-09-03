{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
in {
  home.file.".config/picom.conf".source = ./picom.conf;

  # TODO: breaks if you restart display-manager.service?
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "alacritty";
      # program launcher
      "super + space" = "rofi -show drun";
      # Open rofi as root
      "super + shift + d" = "sudo rofi -show drun -show-icons";
      # make sxhkd reload its configuration files:
      "super + Escape" = "pkill -USR1 -x sxhkd";
      "super + e" = "pcmanfm";
      #################
      # bspwm hotkeys #
      #################
      # Move window into preselect
      "super + s" = "bspc node -n 'last.!automatic.local'";
      # quit/restart bspwm
      "super + shift + {q,r}" = "bspc {quit,wm -r}";
      # close and kill
      "super + {_,shift + }q" = "bspc node -{c,k}";
      # alternate between the tiled and monocle layout
      # ---
      "super + m" = "bspc desktop -l next";
      # Picture in picture mode
      "super + p" =
        "bspc node --state floating; bspc node -g sticky; xdotool getactivewindow windowsize 768 432 windowmove 1137 632";
      # Change volume
      "XF86Audio{Raise,Lower}Volume" = "pamixer -{i,d} 5";
      "XF86AudioMute" = "pamixer --toggle-mute";
      # "XF86AudioMute" = "~/.config/eww/scripts/mute";
      # lockscreen
      "alt + shift + x" = "betterlockscreen -l blur";
      ###############
      # state/flags #
      ###############
      # Change to tiled mode
      "super + t" = "bspc node -t tiled";
      # Change to pseudo_tiled, floating, fullscreen mode
      "super + shift + {t,s,f}" =
        "bspc node -t {pseudo_tiled,floating,fullscreen}";
      # set the node flags
      "super + ctrl + {m,x,y,z}" =
        "bspc node -g {marked,locked,sticky,private}";
      # TODO
      # Hide window
      "super + n" = "$HOME/.config/bspwm/hide.sh";
      "super + b" = "eww close hub || eww open hub";
      ##############
      # focus/swap #
      ##############
      # focus the node in the given direction
      "super + {_,shift + }{h,j,k,l}" =
        "bspc node -{f,s} {west,south,north,east}";
      # focus the node for the given path jump
      "super + {p,b,comma,period}" =
        "bspc node -f @{parent,brother,first,second}";
      # focus the next/previous window in the current desktop
      "super + {_,shift + }c" = "bspc node -f {next,prev}.local.!hidden.window";
      # focus the next/previous desktop in the current monitor
      "super + bracket{left,right}" = "bspc desktop -f {prev,next}.local";
      # focus the last node/desktop
      "super + Tab" = "bspc desktop -f last";
      # focus the older or newer node in the focus history
      "super + {o,i}" =
        "bspc wm -h off; bspc node {older,newer} -f; bspc wm -h on";
      # focus or send to the given desktop
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      #############
      # preselect #
      #############
      # preselect the direction
      "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
      "super + {h,v}" = "bspc node -p {east,south}";
      # preselect the ratio
      "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
      # cancel the preselection for the focused node
      "super + ctrl + space" = "bspc node -p cancel";
      # cancel the preselection for the focused desktop
      "super + ctrl + shift + space" =
        "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";
      ###############
      # move/resize #
      ###############
      # expand a window by moving one of its side outward
      "super + alt + {h,j,k,l}" =
        "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      # contract a window by moving one of its side inward
      "super + alt + shift + {h,j,k,l}" =
        "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
      # move a floating window
      "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
      # Print screen with selection and upload
      "Print" = "screenshot 0 0";
      # Print screen with selection, local
      "shift + Print" = "screenshot 1 0";
      # Print screen and upload
      "control + Print" = "screenshot 0 1";
      # Print screen local
      "control + shift + Print" = "screenshot 1 1";
    };
  };
}
