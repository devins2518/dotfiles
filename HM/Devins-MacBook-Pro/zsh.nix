{ pkgs, config, ... }:

{
  programs = {
    zsh = {
      shellAliases = {
        ls = "ls -l --color=always -H";
        fupdate =
          "darwin-rebuild switch --flake '/Users/devin/Repos/dotfiles/#'";
        fclup =
          "darwin-rebuild switch --flake '/Users/devin/Repos/dotfiles/#' && sudo nix-collect-garbage -d";
      };
    };
  };
}

