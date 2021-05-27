{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    #font = { name = font; };
    theme = {
      package = pkgs.sierra-gtk-theme;
      name = "Sierra-dark";
    };
  };
}
