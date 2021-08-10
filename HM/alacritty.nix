{ pkgs, config, lib, ... }:

let theme = import ./colors.nix { };
in {
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty-ligatures;
    settings = {
      window = { decorations = "none"; };

      font = {
        ligatures = true;
        size = 12;
        normal = {
          family = "Iosevka Nerd Font Mono";
          style = "Medium";
        };
        bold = {
          family = "Iosevka Nerd Font Mono";
          style = "Semibold";
        };
        italic = {
          family = "Iosevka Nerd Font Mono";
          style = "Oblique";
        };
        bold_italic = {
          family = "Iosevka Nerd Font Mono";
          style = "Semibold Oblique";
        };
      };

      colors = {
        primary = theme.primary;
        normal = theme.normal;
        bright = theme.bright;
      };

      background_opacity = 0.7;

      shell = {
        program = "/run/current-system/sw/bin/zsh";
        args = [ "-l" "-c" "tmux new || tmux" ];
      };

    };
  };
}
