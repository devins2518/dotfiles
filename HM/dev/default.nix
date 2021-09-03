rec {
  default = [ ./cursor.nix ./zsh.nix ];
  x-org = [ ./bspwm.nix ./rofi.nix ];
  wayland = [ ];
}
