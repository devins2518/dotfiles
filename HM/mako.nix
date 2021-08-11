{ pkgs, config, lib, ... }:

let
  theme = import ./colors.nix { lib = lib; };
  normal = theme.normal;
  bright = theme.bright;
  vim = theme.vim;
in {
  programs.mako = {
    enable = true;
    anchor = "top-right";
    borderRadius = 4;
    borderSize = 4;
    defaultTimeout = 5000;
    iconPath = "${pkgs.whitesur-icon-theme}/share/icons/WhiteSur-dark";

    groupBy = "app-name";
    format =
      "<b>%s</b>\\n<b><span size='small' color='#6f6f6f'>%a</span></b>\\n\\n<span size='small'>%b</span>";
  };
}
