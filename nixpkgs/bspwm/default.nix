{ config, pkgs, ... }: {
  config = {

    xresources.properties = { "Xcursor.size" = 32; };

    gtk.gtk2.extraConfig = "gtk-cursor-theme-size=32";

    gtk.gtk3.extraConfig = { "gtk-cursor-theme-size" = 32; };

  };
}
