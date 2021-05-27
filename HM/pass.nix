{ config, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    # settings = ;
  };

  services.gpg-agent.enable = true;
  services.gpg-agent.pinentryFlavor = "curses";
}
