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
        monitor = "DP-2";
        height = 34;

        font-0 = "JetBrainsMono Nerd Font:style=Bold:size=12;2";
        font-1 = "Font Awesome 5 Free:style=Solid:size=12;2";
        font-2 = "Font Awesome 5 Free:style=Regular:size=12;2";
        font-3 = "Font Awesome 5 Brands:style=Regular:size=12;2";
        font-4 = "Material Design Icons:style=Regular:size=12;2";

        modules-right = "mem wlan audio right-end-middle-twoo date powermenu";
      };
      "module/wlan" = {
        type = "internal/network";
        interface = "wlp4s0";
        interval = 3.0;

        format-connected = "<label-connected>";
        label-connected = " 直 ";
        label-connected-foreground = normal.cyan;
      };
    };
  };
}
