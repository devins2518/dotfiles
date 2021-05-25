{ config, pkgs, lib, ... }: {

  config = {
    home.file.".p10k.zsh".source = ./p10k.zsh;
    programs.zsh = import ./zsh.nix { inherit pkgs; };
    programs.tmux = import ./tmux.nix;
  };
}

