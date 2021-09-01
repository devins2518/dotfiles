{ config, pkgs, lib, ... }:

{
  networking = {
    networkmanager = { enable = true; };
    useDHCP = false;
  };
}
