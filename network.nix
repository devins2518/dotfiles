{ config, pkgs, lib, ... }:

{
  networking = {
    networkmanager = { enable = true; };
    useDHCP = false;
  };
  #environment.etc."wpa_supplicant.conf".source = config.age.secrets.wpa.path;
}
