{ config, pkgs, ... }:

{
  gtk = {
    gtk3.extraConfig = { gtk-cursor-theme-size = 24; };
    gtk2.extraConfig = "gtk-cursor-theme-size=24";
  };
}
