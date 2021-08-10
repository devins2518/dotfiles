{ pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "WhiteSur-dark-alt-purple";
      icon-theme = "WhiteSur-dark";
      cursor-theme = "Quintom_Ink";
    };
  };
}
