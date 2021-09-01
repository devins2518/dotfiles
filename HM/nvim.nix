{ pkgs, config, lib, ... }:

let package = pkgs.neovim-nightly;
in {
  home.sessionVariables = { EDITOR = "${package}/bin/nvim"; };
  xdg.configFile."nvim".source = ./nvim;
  xdg.configFile."nvim".recursive = true;

  home.packages = [ package ];
  programs.zsh.shellAliases = {
    vim = "nvim";
    vi = "nvim";
  };
}
