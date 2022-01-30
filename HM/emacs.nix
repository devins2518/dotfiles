{ pkgs, config, lib, ... }:

{
  programs.emacs = { enable = true; };
  xdg.configFile."emacs".source = ./emacs;
  xdg.configFile."emacs".recursive = true;
}
