{ config, pkgs, ... }:

{
  programs.gpg = { enable = true;

};

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
    #extraConfig = ''
      #pinentry-program ${pkgs.pinentry-gtk2}/bin/pinentry-curses
    #'';
  };
}
