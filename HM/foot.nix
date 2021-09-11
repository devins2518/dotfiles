{ pkgs, config, lib, ... }:

let theme = import ./colors.nix { lib = lib; };
in {
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        shell = "zsh -l -c 'tmux new || tmux'";
        font = "Iosevka Nerd Font Mono:size=12";
        font-bold = "Iosevka Nerd Font Mono:style=SemiBold:size=12";
        font-italic = "Iosevka Nerd Font Mono:style=Oblique:size=12";
        font-bold-italic =
          "Iosevka Nerd Font Mono:style=SemiBold Oblique:size=12";
        dpi-aware = "auto";
        pad = "20x20";
        word-delimiters = '',│`|:"'()[]{}<>/\'';
        selection-target = "both";
      };

      scrollback = {
        lines = 2000;
        multiplier = "6.0";
      };

      mouse = { hide-when-typing = "yes"; };
      colors = theme.foot;
    };
  };
}
