{ }:

rec {
  primary = {
    background = "#191724";
    foreground = "#e0def4";
  };

  cursor = {
    text = "#191724";
    cursor = "#796268";
  };

  vi_mode_cursor = {
    text = "#191724";
    cursor = "#796268";
  };

  line_indicator = {
    foreground = "None";
    background = "None";
  };

  selection = {
    text = primary.foreground;
    background = "#2A2738";
  };

  normal = {
    black = "#6e6a86";
    red = "#eb6f92";
    green = "#9ccfd8";
    yellow = "#f6c177";
    blue = "#31748f";
    magenta = "#c4a7e7";
    cyan = "#ebbcba";
    white = "#e0def4";
  };

  bright = {
    black = "#6e6a86";
    red = "#eb6f92";
    green = "#9ccfd8";
    yellow = "#f6c177";
    blue = "#31748f";
    magenta = "#c4a7e7";
    cyan = "#ebbcba";
    white = "#e0def4";

  };
}
