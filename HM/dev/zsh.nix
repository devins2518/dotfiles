{ pkgs, config, ... }:

{
  programs = {
    zsh = {
      shellAliases = {
        temps =
          "nvidia-smi -q --display=TEMPERATURE | grep Current; sensors | grep Tdie";
        fupdate =
          "sudo nixos-rebuild switch --flake '/home/devin/Repos/dotfiles/#' --fast";
        fclup =
          "sudo nixos-rebuild switch --flake '/home/devin/Repos/dotfiles/#' --fast && sudo nix-collect-garbage -d";
        ls = "ls -l --color=always";
      };
    };
  };
}

