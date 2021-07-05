{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
in {
  xsession = {
    windowManager = {
      bspwm = {
        monitors = { "DP-2" = [ "I" "II" "III" "IV" "V" "VI" ]; };

        startupPrograms = [ "nvfancontrol" ];

        extraConfig = ''
          bspc rule -a Pavucontrol state=floating rectangle=1000x750+450+70
          bspc rule -a Nm-connection-editor state=floating rectangle=600x600+500+70
        '';

        settings = {
          border_width = 3;
          top_padding = 40;
          left_padding = 10;
          right_padding = 10;
          bottom_padding = 10;
          window_gap = 6;
        };
      };
    };
  };
}
