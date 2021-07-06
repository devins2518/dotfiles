{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
  vim = theme.vim;
in {

  programs.rofi = {
    extraConfig = {
      width = 40;
      font = "Iosevka Serif 20";
    };

    font = "Iosevka Serif 20";
  };
}
