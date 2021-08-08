{ pkgs, config, lib, inputs, ... }:
let nur-packages = with pkgs.nur.repos.devins2518; [ paper midle ];
in {
  environment = {
    sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "river";
      XDG_CURRENT_DESKTOP = "river";
      MOZ_ENABLE_WAYLAND = "1";
      CLUTTER_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland-egl";
      ECORE_EVAS_ENGINE = "wayland-egl";
      ELM_ENGINE = "wayland_egl";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      NO_AT_BRIDGE = "1";
    };

    systemPackages = with pkgs;
      [ river-git kile-wl-git xwayland swaylock wofi light libinput wlr-randr ]
      ++ nur-packages;
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd river";
      };
    };
  };
}
