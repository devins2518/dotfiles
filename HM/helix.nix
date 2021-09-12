{ pkgs, config, lib, ... }:

{
  xdg.configFile."helix".source = ./helix;
  xdg.configFile."helix".recursive = true;
}
