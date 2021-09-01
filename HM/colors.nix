{ lib ? null, ... }:

rec {
  primary = {
    background = "#1d2021";
    foreground = "#d4be98";
  };

  normal = {
    black = "#32302f";
    red = "#ea6962";
    green = "#a9b665";
    yellow = "#d8a657";
    blue = "#7daea3";
    magenta = "#d3869b";
    cyan = "#89b482";
    white = "#d4be98";
  };

  bright = {
    black = "#32302f";
    red = "#ea6962";
    green = "#a9b665";
    yellow = "#d8a657";
    blue = "#7daea3";
    magenta = "#d3869b";
    cyan = "#89b482";
    white = "#d4be98";
  };

  foot = with lib.strings; {
    foreground = removePrefix "#" primary.foreground;
    background = removePrefix "#" primary.background;
    regular0 = removePrefix "#" normal.black;
    regular1 = removePrefix "#" normal.red;
    regular2 = removePrefix "#" normal.green;
    regular3 = removePrefix "#" normal.yellow;
    regular4 = removePrefix "#" normal.blue;
    regular5 = removePrefix "#" normal.magenta;
    regular6 = removePrefix "#" normal.cyan;
    regular7 = removePrefix "#" normal.white;
    bright0 = removePrefix "#" bright.black;
    bright1 = removePrefix "#" bright.red;
    bright2 = removePrefix "#" bright.green;
    bright3 = removePrefix "#" bright.yellow;
    bright4 = removePrefix "#" bright.blue;
    bright5 = removePrefix "#" bright.magenta;
    bright6 = removePrefix "#" bright.cyan;
    bright7 = removePrefix "#" bright.white;
  };

  vim = {
    bg_dark = "#1f2335";
    bg = "#1a1b26";
    bg_highlight = "#292e42";
    terminal_black = "#414868";
    fg = "#c0caf5";
    fg_dark = "#a9b1d6";
    fg_gutter = "#3b4261";
    dark3 = "#545c7e";
    comment = "#565f89";
    dark5 = "#737aa2";
    blue0 = "#3d59a1";
    blue = "#7aa2f7";
    cyan = "#7dcfff";
    blue1 = "#2ac3de";
    blue2 = "#0db9d7";
    blue5 = "#89ddff";
    blue6 = "#B4F9F8";
    blue7 = "#394b70";
    magenta = "#bb9af7";
    purple = "#9d7cd8";
    orange = "#ff9e64";
    yellow = "#e0af68";
    green = "#9ece6a";
    green1 = "#73daca";
    green2 = "#41a6b5";
    teal = "#1abc9c";
    red = "#f7768e";
    red1 = "#db4b4b";
  };
}
