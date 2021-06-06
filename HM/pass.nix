{ config, pkgs, ... }:

{
  programs.gnupg = {
    enable = true;

    gpg-agent = {
      enable = true;
      pinentryFlavor = "curses";
    };
  };
}

