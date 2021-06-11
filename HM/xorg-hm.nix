{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix {};
  normal = theme.normal;
  bright = theme.bright;
in {
  xsession.scriptPath = ".xinitrc";
  xsession.initExtra = "feh /etc/wallpaper/wallpaper.png --bg-fill &";

  #home.file.".config/polybar".source = ./polybar;
  #home.file.".config/polybar".recursive = true;
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    #--config=$HOME/.config/polybar/config.ini 
    script = ''
      polybar bar >>/tmp/polybar1.log 2>&1 & disown
    '';
    settings = {
      "bar/bar" = {
        monitor = "eDP1";
        monitor-fallback = "DP-2";
        width = "100%";
        height = 65;
        background = normal.black;
        foreground = normal.red;
        bottom = false;

        line-size = 5;

        font-0 = "JetBrainsMono Nerd Font:style=Bold:size=20;2";
        font-1 = "Font Awesome 5 Free:style=Solid:size=20;2";
        font-2 = "Font Awesome 5 Free:style=Regular:size=20;2";
        font-3 = "Font Awesome 5 Brands:style=Regular:size=20;2";
        font-4 = "Material Design Icons:style=Regular:size=20;2";

        wm-restack = "bspwm";
        tray-position = "right";

        modules-left = "bspwm";
        modules-center = "xwindow";
        modules-right =
          "mem wlan audio right-end-middle-two xbacklight right-end-middle battery right-end-middle-twoo date powermenu";
      };

      "module/mem" = {
        type = "custom/script";
        exec =
          "/run/current-system/sw/bin/free -m | /run/current-system/sw/bin/sed -n 's/^Mem:s+[0-9]+s+([0-9]+)s.+/1/p'";
        format = "<label>";
        label = " %output%Mb";
        label-padding = 1;
      };

      "module/bspwm" = {
        type = "internal/bspwm";

        pin-workspaces = true;
        inline-mode = true;
        enable-click = true;
        enable-scroll = true;
        reverse-scroll = false;

        format = "<label-state>";

        ws-icon-0 = "I;%{F#c2f0fc}";
        ws-icon-1 = "II;%{F#fabea7}";
        ws-icon-2 = "III;%{F#88e1f2}";
        ws-icon-3 = "IV;%{F#e36387}";
        ws-icon-4 = "V;%{F#cceabb}";
        ws-icon-5 = "VI;%{F#eaa9ce}";

        label-focused = "%icon%";
        label-focused-underline = normal.red;

        label-focused-padding = 1;

        label-occupied = "%icon%";
        label-occupied-foreground = "#ffffff";
        label-occupied-padding = 1;

        label-empty = "%icon%";
        label-empty-foreground = "#ffffff";
        label-empty-padding = 1;

        label-urgent = "%icon%";
        xxlabel-urgent-foreground = "#88C0D0";
        label-urgent-padding = 1;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title%";
        label-maxlen = 30;
        format-foreground = normal.red;
        format-background = normal.black;
        format-padding = 1;
      };

      "module/xbacklight" = {
        type = "internal/xbacklight";
        format = "<label>";
        format-prefix = " ";
        format-prefix-foreground = normal.black;
        format-prefix-background = normal.red;
        label = "%percentage%%";
        format-foreground = normal.black;
        format-background = normal.red;
        format-padding = 1;
      };

      "module/date" = {
        type = "internal/date";
        interval = 5;

        time = "%I:%M";
        format-prefix = " ";
        format-prefix-foreground = normal.black;
        format-prefix-background = normal.blue;
        format-foreground = normal.black;
        format-background = normal.blue;
        label = "%time%";
        format-padding = 1;
      };

      "module/audio" = {
        type = "internal/alsa";
        interval = 5;
        format-volume = "<ramp-volume><label-volume>";
        format-muted = "<label-muted>";
        format-muted-prefix-font = 2;
        format-muted-prefix = "";
        format-muted-prefix-foreground = normal.green;
        format-muted-prefix-background = normal.black;
        format-muted-prefix-padding = 1;

        label-volume = "%percentage%%";
        label-volume-foreground = normal.green;
        label-volume-background = normal.black;
        label-volume-padding = 1;

        label-muted = "Muted";
        label-muted-foreground = normal.green;
        label-muted-background = normal.black;
        label-muted-padding = 1;

        ramp-volume = [ "" "" "" ];
        ramp-volume-foreground = normal.green;
        ramp-volume-background = normal.black;
        ramp-volume-padding = 1;

        click-right = "$HOME/.config/polybar/scripts/autoclose.sh pavucontrol";
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT1";
        adapter = "AC0";
        full-at = 98;

        format-charging = "<animation-charging> <label-charging>";
        label-charging = "%percentage%%";
        format-charging-foreground = normal.blue;
        format-charging-background = normal.black;

        format-discharging = "<ramp-capacity> <label-discharging>";
        label-discharging = "%percentage%%";
        format-discharging-foreground = normal.red;
        format-discharging-background = normal.black;

        format-full-prefix = " ";
        format-full-prefix-foreground = normal.blue;
        format-foreground = normal.blue;
        format-background = normal.black;

        label-discharging-foreground = normal.red;
        label-charging-foreground = normal.blue;
        label-padding = 1;

        ramp-capacity = [ "" "" "" "" "" ];
        ramp-capacity-foreground = normal.red;

        animation-charging = [ "" "" "" "" "" ];
        animation-charging-foreground = normal.blue;
        animation-charging-framerate = 750;

        format-charging-padding = 1;
        format-discharging-padding = 1;
      };

      "module/left-end" = {
        type = "custom/text";
        content-background = normal.blue;
        content-foreground = normal.black;
        content = "%{T3}%{T-}";
      };

      "module/right-end" = {
        type = "custom/text";
        content-background = normal.blue;
        content-foreground = normal.black;
        content = "%{T}%{T}";
      };

      "module/right-end-middle" = {
        type = "custom/text";
        content-background = normal.red;
        content-foreground = normal.black;
        content = "%{T3}%{T-}";
      };

      "module/right-mid" = {
        type = "custom/text";
        content-background = normal.cyan;
        content-foreground = normal.black;
        content = "%{T3}%{T-}";
      };

      "module/right-end-middlee" = {
        type = "custom/text";
        content-background = normal.red;
        content-foreground = normal.black;
        content = "%{T3}%{T-}";
      };

      "module/right-end-middle-two" = {
        type = "custom/text";
        content-background = normal.black;
        content-foreground = normal.red;
        content = "%{T3}%{T-}";
      };

      "module/right-end-middle-tww" = {
        type = "custom/text";
        content-background = normal.black;
        content-foreground = normal.cyan;
        content = "%{T3}%{T-}";
      };

      "module/right-end-middle-twoo" = {
        type = "custom/text";
        content-background = normal.black;
        content-foreground = normal.blue;
        content = "%{T3}%{T-}";
      };

      "module/square" = {
        type = "custom/text";
        content-background = normal.blue;
        content-foreground = normal.black;
        content = "%{T3}%{T-}";
      };

      "module/powermenu" = {
        type = custom/menu;

        expand-right = false;

        label-open-font = 2;
        label-open = "";
        label-open-foreground = normal.black;
        label-open-background = normal.green;
        label-open-padding = 1;
        label-close = "";
        label-close-foreground = normal.black;
        label-close-background = normal.red;

        label-close-padding = 1;

        label-separator = " | ";

        menu-0 = [ " " "" "" "" "" ];
        menu-0-0-exec = "poweroff";
        menu-0-1-exec = "reboot";
        menu-0-2-exec = "systemctl suspend";
        menu-0-3-exec = "bspc quit";
        menu-0-4-exec = "xset dpms force off";
      };

      "module/wlan" = {
        type = "internal/network";
        interface = "wlp2s0";
        interval = 3.0;

        format-connected = "<label-connected>";
        label-connected = " 直 ";
        label-connected-foreground = normal.cyan;
      };

    };
  };
  #programs.rofi = {
    #package =
      #pkgs.rofi.override { plugins = with pkgs; [ rofi-calc rofi-emoji ]; };
    #enable = true;
    #extraConfig = {
      #modi = "combi,calc";
      #combi-modi = "drun,run,window,file-browser,ssh,keys,emoji";
    #};
    #font = "Cascadia Code 10";
    #colors = {
      #rows = {
        #normal = {
          #background = bg;
          #foreground = fg;
          #backgroundAlt = bg;
          #highlight = {
            #background = pink;
            #foreground = fg;
          #};
        #};

      #};
      #window = {
        #background = bg;
        #separator = pink;
        #border = pink;
      #};
    #};
  #};

  home.file.".config/picom.conf".source = ./picom.conf;

  home.file.".icons/default".source =
    "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors";

  home.file.".config/bspwm".source = ./bspwm;
  home.file.".config/bspwm".recursive = true;

  home.file.".config/rofi".source = ./rofi;
  home.file.".config/rofi".recursive = true;

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
          bspc node --state \~floating; bspc node -g sticky; xdotool getactivewindow windowsize 768 432 windowmove 1137 632

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

      super + {h,v}
          bspc node -p {east,south}

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
          screenshot 0 0

      # Print screen with selection, local
      shift + Print
          screenshot 1 0

      # Print screen and upload
      control + Print
          screenshot 0 1

      # Print screen local
      control + shift + Print
          screenshot 1 1
    '';
  };
}
