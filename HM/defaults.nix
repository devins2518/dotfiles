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
    nix-direnv = { enable = true; };
    enableZshIntegration = true;
  };

  home.username = "devin";
  home.homeDirectory = "/home/devin";

  news.display = "silent";

  home.file.".lldbinit".text = ''
    settings set stop-line-count-before 20
    settings set stop-line-count-after 20
  '';
}
