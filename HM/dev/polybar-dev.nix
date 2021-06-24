{ pkgs, config, lib, ... }:

{
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
      };
    };
  };
}
