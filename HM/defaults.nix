{ config, pkgs, ... }:

{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = false;
    };
  };

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
    enableZshIntegration = true;
  };

  home.username = "devin";
  home.homeDirectory = "/home/devin";

  news.display = "silent";
}
