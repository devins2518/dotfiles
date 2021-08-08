{ pkgs, config, ... }:

let theme = import ./colors.nix { };
in {
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "Iosevka Nerd Font Mono:size=12";
        font-bold = "Iosevka Nerd Font Mono:size=12";
        pad = "20x20";
      };

      mouse = { hide-when-typing = "yes"; };
      tweak = { allow-overflowing-double-width-glyphs = "true"; };
      # font = {
      #   normal = {
      #     style = "Medium";
      #   };
      #   bold = {
      #     family = "Iosevka Nerd Font Mono";
      #     style = "Semibold";
      #   };
      #   italic = {
      #     family = "Iosevka Nerd Font Mono";
      #     style = "Oblique";
      #   };
      #   bold_italic = {
      #     family = "Iosevka Nerd Font Mono";
      #     style = "Semibold Oblique";
      #   };
      # };

      # colors = {
      #   primary = theme.primary;
      #   normal = theme.normal;
      #   bright = theme.bright;
      # };

      # background_opacity = 0.7;

      # shell = {
      #   program = "/run/current-system/sw/bin/zsh";
      #   args = [ "-l" "-c" "tmux new || tmux" ];
      # };

    };
  };
}
