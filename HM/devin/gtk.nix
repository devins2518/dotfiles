{ config, pkgs, ... }:

{
  gtk = {
    gtk3.extraConfig = { gtk-cursor-theme-size = 40; };
    gtk2.extraConfig = "gtk-cursor-theme-size=40";
  };
}
