{ config, pkgs, lib, ... }:

{
  programs.gpg = { enable = true; };

  services = lib.mkIf pkgs.stdenv.isLinux {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gtk2";
    };
  };

  home = lib.mkIf pkgs.stdenv.isDarwin {
    file.".gnupg/gpg-agent.conf".text = ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
    '';
  };

}
