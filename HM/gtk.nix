{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-dark-alt-purple";
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };
  };
}
