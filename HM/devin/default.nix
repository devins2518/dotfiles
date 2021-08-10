rec {
  default = [ ./cursor.nix ./gtk.nix ./zsh.nix ];
  x-org = [ ./bspwm.nix ./rofi.nix ./polybar.nix ];
  wayland = [ ./dconf.nix ];
}
