{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
  vim = theme.vim;
in {
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun";
      columns = 1;
      lines = 5;
      show-icons = true;
      icon-theme = "Papirus-Dark";
      terminal = "alacritty";
      drun-display-format = "{icon} {name}";
      display-drun = "Open";
      location = 0;
      separator-style = "solid";
      disable-history = true;
      hide-scrollbar = true;
      matching = "fuzzy";
      show-match = false;
    };

    theme = let inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background-color = mkLiteral vim.bg;
        border-color = mkLiteral vim.blue;
        text-color = mkLiteral bright.white;
        separator-color = mkLiteral "@border-color";
        show-icons = mkLiteral "true";
      };

      "window" = {
        border = mkLiteral "3px";
        padding = mkLiteral "10px";
        height = mkLiteral "500px";
        width = mkLiteral "1500px";
      };

      "mainbox" = { padding = mkLiteral "10px"; };

      "inputbar" = {
        border = mkLiteral "1px";
        children = map mkLiteral [ "prompt" "entry" ];
      };

      "prompt" = {
        background-color = mkLiteral "@border-color";
        padding = mkLiteral "10px 10px 0px";
        text-color = mkLiteral "@background-color";
      };

      "entry" = { padding = mkLiteral "10px"; };

      "listview" = {
        border = mkLiteral "0px 0px 0px";
        padding = mkLiteral "12px 0px 0px";
        columns = mkLiteral "2";

      };

      "element" = { padding = mkLiteral "10px"; };

      "element selected" = {
        background-color = mkLiteral vim.blue0;
        text-color = mkLiteral "@text-color";
      };

      "element urgent" = {
        background-color = mkLiteral normal.red;
        text-color = mkLiteral "@background-color";
      };

      "element active" = {
        background-color = mkLiteral normal.yellow;
        text-color = "@background-color";
      };

      "element-icon" = { size = mkLiteral "2ch"; };
    };

  };
}
