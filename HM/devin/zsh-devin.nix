{ pkgs, config, ... }:

{
  programs = {
    zsh = { shellAliases = { temps = "sensors | grep coretemp -A 5"; }; };
  };
}

