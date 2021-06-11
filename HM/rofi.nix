{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
in {
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "combi";
      combi-modi = "drun,run,window";
    };
    font = "Iosevka 25";

    theme = let inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background-color = mkLiteral normal.black;
        border-color = mkLiteral normal.blue;
        text-color = mkLiteral normal.white;
        separator-color = mkLiteral "@border-color";
        # TODO: icons no work
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
        background-color = mkLiteral normal.cyan;
        text-color = mkLiteral "@background-color";
      };

      "element urgent" = {
        background-color = mkLiteral normal.red;
        text-color = mkLiteral "@background-color";
      };

      "element active" = {
        background-color = mkLiteral normal.yellow;
        text-color = "@background-color";
      };
    };

  };
}
