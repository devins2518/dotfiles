{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
  vim = theme.vim;
in {
  home.packages = with pkgs; [ bspwm ];
  xsession = {
    enable = true;
    windowManager = {
      bspwm = {
        enable = true;

        startupPrograms = [
          "feh --bg-fill /etc/wallpaper/wallpaper.png"
          "picom --config $HOME/.config/picom.conf"
          "alttab -w 1 -i 128x128"
          "xset r rate 300 50"
        ];

        extraConfig = ''
          #eww daemon && sleep 1 && eww open gnome-right
          #if [ -e /tmp/ewwpipe ]; then
          #  mkfifo /tmp/ewwpipe
          #fi

          bspc desktop \^2 --layout monocle
          bspc rule -a Firefox desktop='^2' layout=monocle follow=on
          bspc rule -a Gimp-2.10 desktop='^2' layout=monocle follow=on
          bspc rule -a discord desktop='^3' layout=monocle
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
          split_ratio = 0.5;
          single_monocle = true;
          borderless_monocle = false;
          gapless_monocle = false;
          padless_monocle = false;

          normal_border_color = vim.cyan;
          active_border_color = normal.green;
          focused_border_color = normal.blue;
          presel_feedback_color = normal.magenta;
        };
      };
    };
  };
}
