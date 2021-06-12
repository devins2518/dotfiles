{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
in {

  home.packages = with pkgs; [ bspwm ];
  xsession = {
    enable = true;
    windowManager = {

      bspwm = {
        enable = true;
        monitors = { "" = [ "I" "II" "III" "IV" "V" "VI" ]; };

        startupPrograms = [
          "feh --bg-fill /etc/wallpaper/wallpaper.png"
          "picom --config $HOME/.config/picom.conf"
          "alttab -w 1 -i 128x128"
        ];

        extraConfig = ''
          bspc desktop \^2 --layout monocle
          bspc rule -a Firefox desktop='^2' layout=monocle follow=on
          bspc rule -a Gimp-2.10 desktop='^2' layout=monocle follow=on
          bspc rule -a discord desktop='^3' layout=monocle follow=on
          bspc rule -a Pavucontrol state=floating rectangle=1000x750+450+70
          bspc rule -a Nm-connection-editor state=floating rectangle=600x600+500+70
        '';

        rules = {
          # TODO:
          #"Firefox" = {
          #desktop = "^2";
          #layout = "monocle";
          #follow = true;
          #};
          #"Gimp" = {
          #desktop = "^2";
          #layout = "monocle";
          #follow = true;
          #};
          "Alacritty" = {
            desktop = "^1";
            state = "tiled";
            follow = true;
          };
          #"discord" = {
          #desktop = "^3";
          #layout = "monocle";
          #follow = true;
          #};
        };

        settings = {
          border_width = 5;
          top_padding = 80;
          left_padding = 20;
          right_padding = 20;
          bottom_padding = 20;
          window_gap = 12;

          split_ratio = 0.5;
          single_monocle = true;
          borderless_monocle = false;
          gapless_monocle = false;
          paddless_monocle = false;

          normal_border_color = normal.blue;
          active_border_color = normal.green;
          focused_border_color = normal.magenta;
          presel_feedback_color = normal.yellow;
        };
      };
    };
  };
}
