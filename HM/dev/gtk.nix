{ config, pkgs, ... }:

{
  gtk = {
    gtk3.extraConfig = { gtk-cursor-theme-size = 16; };
    gtk2.extraConfig = "gtk-cursor-theme-size=16";
  };
}
