{ pkgs, config, lib, inputs, ... }:

{
  programs = {
    zsh = {
      initExtra = ''
      '';

      initExtraFirst = ''
      '';

      plugins = [
      ];
    };
  };
}
