{ pkgs, config, lib, ... }:

with import ./colors.nix { }; {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        padding = 8;
        markup = "full";
        alignment = "center";
        vertical_alignment = "top";
        word_wrap = "yes";
        horizontal_padding = 8;
        show_indicators = true;
        frame_width = 5;
        format = "<b>%s</b>\\n\\n%b";
        font = "Iosevka Nerd Font 10";
        frame_color = "#a57ec8";
        separator_color = "frame";
        icon_position = "left";
        max_icon_size = 32;
        geometry = "700x500-700+70";
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        indicate_hidden = "yes";
      };

      urgency_low = {
        background = "#2e2e2e";
        foreground = "#c5cdd9";
        timeout = 10;
      };

      urgency_normal = {
        background = "#2b2d37";
        foreground = "#d5ddea";
        timeout = 10;
      };

      urgency_critical = {
        background = "#2b2d37";
        foreground = "#d5ddea";
        frame_color = "#d8394b";
      };
    };
  };
}
