{ config, pkgs, lib, ... }:

{
  programs.gpg = { enable = true; };

  services.gpg-agent = if pkgs.stdenv.isLinux then {
    enable = true;
    pinentryFlavor = "gtk2";
  } else {
    enable = false;
  };

  home.file.".gnupg/gpg-agent.conf".text = if pkgs.stdenv.isDarwin then ''
    pinentry-program ${pkgs.pinentry_mac}
  '' else
    "";

}
