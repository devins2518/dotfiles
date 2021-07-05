{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
  vim = theme.vim;
in {

  programs.rofi = {
    extraConfig = {
      width = 20;
      font = "Iosevka Nerd Font Mono 12";
    };

    font = "Iosevka 12";
  };
}
