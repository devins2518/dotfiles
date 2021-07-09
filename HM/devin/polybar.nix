{ pkgs, config, lib, ... }:

let
  theme = import ../colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
  vim = theme.vim;
in {
  services.polybar = {
    settings = {
      "bar/bar" = {
        monitor = "eDP1";
        height = 65;

        font-0 = "JetBrainsMono Nerd Font:style=Bold:size=20;2";
        font-1 = "Font Awesome 5 Free:style=Solid:size=20;2";
        font-2 = "Font Awesome 5 Free:style=Regular:size=20;2";
        font-3 = "Font Awesome 5 Brands:style=Regular:size=20;2";
        font-4 = "Material Design Icons:style=Regular:size=20;2";

        modules-right =
          "mem wlan audio right-end-middle-two xbacklight right-end-middle battery right-end-middle-twoo date powermenu";
      };

      "module/wlan" = {
        type = "internal/network";
        interface = "wlp2s0";
        interval = 3.0;

        format-connected = "<label-connected>";
        label-connected = " 直 ";
        label-connected-foreground = normal.cyan;
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT1";
        adapter = "AC0";
        full-at = 98;

        format-charging = "<animation-charging> <label-charging>";
        label-charging = "%percentage%%";
        format-charging-foreground = normal.blue;
        format-charging-background = vim.bg;

        format-discharging = "<ramp-capacity> <label-discharging>";
        label-discharging = "%percentage%%";
        format-discharging-foreground = normal.red;
        format-discharging-background = vim.bg;

        format-full-prefix = " ";
        format-full-prefix-foreground = normal.blue;
        format-foreground = normal.blue;
        format-background = vim.bg;

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

    };
  };
}
