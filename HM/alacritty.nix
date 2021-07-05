{ pkgs, config, ... }:

let theme = import ./colors.nix { };
in {
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty-ligatures;
    settings = {
      window = { decorations = "none"; };

      font = {
        ligatures = true;
        size = 11;
        normal = {
          family = "Luxi Mono";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "Luxi Mono";
          style = "Oblique";
          # family = "Iosevka Nerd Font Mono";
          # style = "Bold Italic";
        };
        bold_italic = {
          family = "Luxi Mono";
          style = "Bold Oblique";
          # family = "Iosevka Nerd Font Mono";
          # style = "Bold Italic";
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
