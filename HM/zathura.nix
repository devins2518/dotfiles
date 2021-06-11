{ pkgs, config, ... }:

let
  theme = import ./colors.nix { };
in {
  programs.zathura = {
    enable = true;
  };
}
