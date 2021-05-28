{ config, lib, pkgs, ... }:

rec {
  imports = import ./programs ++ [ ./bspwm/default.nix ];
}
