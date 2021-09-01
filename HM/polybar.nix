{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
  vim = theme.vim;
in {
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    #--config=$HOME/.config/polybar/config.ini 
    script = ''
      polybar bar >>/tmp/polybar1.log 2>&1 & disown
    '';
    settings = {
      "bar/bar" = {
        width = "100%";
        background = vim.bg;
        foreground = normal.red;
        bottom = false;

        line-size = 5;

        wm-restack = "bspwm";
        tray-position = "right";

        modules-left = "bspwm";
        modules-center = "xwindow";
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
        format-font = 5;

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
        format-background = vim.bg;
        format-padding = 1;
      };

      "module/xbacklight" = {
        type = "internal/xbacklight";
        format = "<label>";
        format-prefix = " ";
        format-prefix-foreground = vim.bg;
        format-prefix-background = normal.red;
        label = "%percentage%%";
        format-foreground = vim.bg;
        format-background = normal.red;
        format-padding = 1;
      };

      "module/date" = {
        type = "internal/date";
        interval = 5;

        time = "%I:%M";
        format-prefix = " ";
        format-prefix-foreground = vim.bg;
        format-prefix-background = normal.blue;
        format-foreground = vim.bg;
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
        format-muted-prefix-background = vim.bg;
        format-muted-prefix-padding = 1;

        label-volume = "%percentage%%";
        label-volume-foreground = normal.green;
        label-volume-background = vim.bg;
        label-volume-padding = 1;

        label-muted = "Muted";
        label-muted-foreground = normal.green;
        label-muted-background = vim.bg;
        label-muted-padding = 1;

        ramp-volume = [ "" "" "" ];
        ramp-volume-foreground = normal.green;
        ramp-volume-background = vim.bg;
        ramp-volume-padding = 1;

        click-right = "$HOME/.config/polybar/scripts/autoclose.sh pavucontrol";
      };

      "module/left-end" = {
        type = "custom/text";
        content-background = normal.blue;
        content-foreground = vim.bg;
        content = "%{T3}%{T-}";
      };

      "module/right-end" = {
        type = "custom/text";
        content-background = normal.blue;
        content-foreground = vim.bg;
        content = "%{T}%{T}";
      };

      "module/right-end-middle" = {
        type = "custom/text";
        content-background = normal.red;
        content-foreground = vim.bg;
        content = "%{T3}%{T-}";
      };

      "module/right-mid" = {
        type = "custom/text";
        content-background = normal.cyan;
        content-foreground = vim.bg;
        content = "%{T3}%{T-}";
      };

      "module/right-end-middlee" = {
        type = "custom/text";
        content-background = normal.red;
        content-foreground = vim.bg;
        content = "%{T3}%{T-}";
      };

      "module/right-end-middle-two" = {
        type = "custom/text";
        content-background = vim.bg;
        content-foreground = normal.red;
        content = "%{T3}%{T-}";
      };

      "module/right-end-middle-tww" = {
        type = "custom/text";
        content-background = vim.bg;
        content-foreground = normal.cyan;
        content = "%{T3}%{T-}";
      };

      "module/right-end-middle-twoo" = {
        type = "custom/text";
        content-background = vim.bg;
        content-foreground = normal.blue;
        content = "%{T3}%{T-}";
      };

      "module/square" = {
        type = "custom/text";
        content-background = normal.blue;
        content-foreground = vim.bg;
        content = "%{T3}%{T-}";
      };

      "module/powermenu" = {
        type = custom/menu;

        expand-right = false;

        label-open-font = 2;
        label-open = "";
        label-open-foreground = vim.bg;
        label-open-background = normal.green;
        label-open-padding = 1;
        label-close = "";
        label-close-foreground = vim.bg;
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
    };
  };
}
