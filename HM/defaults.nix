{ config, pkgs, ... }:

{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
    enableZshIntegration = true;
  };

  home.username = "devin";
  home.homeDirectory = "/home/devin";

  news.display = "silent";
}
