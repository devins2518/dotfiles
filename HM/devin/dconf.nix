{ pkgs, ... }:

{
  dconf.settings = { "org/gnome/desktop/interface" = { cursor-size = 24; }; };
}
