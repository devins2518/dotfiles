{ config, pkgs, lib, ... }:

let
  pinentry-path =
    "${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac";
in {
  programs.gpg = {
    enable = true;
    homedir = "/Users/devin/.gnupg";
  };

  services = lib.mkIf pkgs.stdenv.isLinux {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gtk2";
    };
  };

  home = lib.mkIf pkgs.stdenv.isDarwin {
    file.".gnupg/gpg-agent.conf".text = "pinentry-program ${pinentry-path}";
  };
}
