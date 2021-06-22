{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
in {
  xsession = {
    windowManager = {
      bspwm = {
        startupPrograms = [ "nvfancontrol" ];
      };
    };
  };
}
