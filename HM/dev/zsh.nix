{ pkgs, config, ... }:

{
  programs = {
    zsh = {
      shellAliases = {
        temps =
          "nvidia-smi -q --display=TEMPERATURE | grep Current; sensors | grep Tdie";
      };
    };
  };
}

