{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
in {
  xsession = {
    pointerCursor.size = 40;

    windowManager = {
      bspwm = {
        monitors = { "eDP1" = [ "I" "II" "III" "IV" "V" "VI" ]; };


        extraConfig = ''
          bspc rule -a Pavucontrol state=floating rectangle=1000x750+450+70
          bspc rule -a Nm-connection-editor state=floating rectangle=600x600+500+70
        '';
        settings = {
          border_width = 5;
          top_padding = 80;
          left_padding = 20;
          right_padding = 20;
          bottom_padding = 20;
          window_gap = 12;
        };
      };
    };
  };
}
