{ pkgs, config, lib, ... }:

with import ./colors.nix { }; {
  xsession.scriptPath = ".xinitrc";
  xsession.initExtra = "feh /etc/wallpaper/spaceman.png --bg-fill &";
  home.file."background-image" = {
    source = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/ox/wallhaven-oxkjgm.jpg";
      sha512 = lib.fakeSha256;
    };
    target = "/etc/wallpaper/spaceman.png";
  };
  #windowManager = { bspwm.enable = true; };
  #desktopManager = { gnome.enable = true; };

  #services.polybar = {
    #enable = true;
    #package = pkgs.polybarFull;
    #script = ''
      #polybar eDP1 &
    #'';
    #extraConfig = ''
      #[colors]
      #; background = ''${xrdb:background}
      #background = ${drbg}
      #background-alt = #444444
      #; foreground =
      #foreground = ${fg}
      #foreground-alt = ''${xrdb:color7}
      #primary = ${pink}
      #secondary = #0000ff
      #alert = #ffff00

      #[bar/eDP1]
      #;monitor = eDP-1
      #width = 100%
      #height = 15
      #;offset-x = 1%
      #;offset-y = 1%
      #;radius = 15.5
      #fixed-center = false
      #tray-position = right

      #background = ''${colors.background}
      #foreground = ''${colors.foreground}

      #line-size = 2
      #line-color = #f00

      #;border-left-size = 16
      #;border-right-size = 16
      #;border-top-size = 8
      #;border-bottom-size = 0
      #border-color = #00000000

      #;padding-left = 2
      #;padding-right = 2

      #module-margin-left = 1
      #module-margin-right = 1

      #font-0 = "Hack:pixelsize=12;2"
      #font-1 = "Font Awesome 5 Free:style=Regular:pixelsize=14;3"
      #font-2 = "Font Awesome 5 Free:style=Solid:pixelsize=14;3"
      #font-3 = "Font Awesome 5 Brands:pixelsize=14;3"

      #modules-left = i3
      #modules-right =  network-wlan battery-internal pulseaudio date separator power-menu

      #wm-restack = i3

      #override-redirect = false

      #;scroll-up = bspwm-desknext
      #;scroll-down = bspwm-deskprev

      #scroll-up = i3wm-wsnext
      #scroll-down = i3wm-wsprev

      #cursor-click = pointer
      #cursor-scroll = ns-resize

      #;enable-ipc = true

      #[module/network-wlan]
      #type = internal/network
      #interface = wlp0s20f3
      #format-connected = %{F${pink}}%{F-} <label-connected>
      #label-connected =  %essid%
      #label-connected-foreground = #eefafafa
      #label-disconnected = not connected
      #label-disconnected-foreground = #66ffffff
      #animation-packetloss-framerate = 500
      #interval = 10.0;


      #[module/battery-internal]
      #type = internal/battery

      #; This is useful in case the battery never reports 100% charge
      #; full-at = 99

      #; Use the following command to list batteries and adapters:
      #; $ ls -1 /sys/class/power_supply/
      #battery = BAT0
      #adapter = AC

      #poll-interval = 100

      #time-format = %H:%M

      #format-charging = <animation-charging> <label-charging>
      #format-discharging = <ramp-capacity> <label-discharging>

      #label-charging = %percentage%%

      #label-discharging = %percentage%%

      #label-full = %{F${pink}}%{F-} 100%

      #ramp-capacity-0 =%{F${pink}}%{F-}
      #ramp-capacity-1 =%{F${pink}}%{F-}
      #ramp-capacity-2 =%{F${pink}}%{F-}
      #ramp-capacity-3 =%{F${pink}}%{F-}
      #ramp-capacity-4 =%{F${pink}}%{F-}

      #bar-capacity-width = 10

      #animation-charging-0 =%{F${pink}}%{F-}
      #animation-charging-1 =%{F${pink}}%{F-}
      #animation-charging-2 =%{F${pink}}%{F-}
      #animation-charging-3 =%{F${pink}}%{F-}
      #animation-charging-4 =%{F${pink}}%{F-}
      #; Framerate in milliseconds
      #animation-charging-framerate = 500

      #animation-discharging-0 =%{F${pink}}%{F-}
      #animation-discharging-1 =%{F${pink}}%{F-}
      #animation-discharging-2 =%{F${pink}}%{F-}
      #animation-discharging-3 =%{F${pink}}%{F-}
      #animation-discharging-4 =%{F${pink}}%{F-}

      #animation-discharging-framerate = 500

      #[module/pulseaudio]
      #type = internal/pulseaudio

      #use-ui-max = true

      #interval = 5

      #format-volume = <ramp-volume> <label-volume>

      #label-muted = %{F${pink}}%{F-} off

      #ramp-volume-0 =%{F${pink}}%{F-}
      #ramp-volume-1 =%{F${pink}}%{F-}
      #ramp-volume-2 =%{F${pink}}%{F-}

      #click-right = pavucontrol &


      #[module/power-menu]
      #type = custom/menu

      #expand-right = true

      #menu-0-0 ="|"
      #menu-0-0-exec =
      #menu-0-1 ="%{F${pink}}%{F-}"
      #menu-0-1-exec = systemctl suspend
      #menu-0-2 = "%{F${pink}}%{F-}"
      #menu-0-2-exec = reboot
      #menu-0-3 = "%{F${pink}}%{F-}"
      #menu-0-3-exec = shutdown now
      #menu-0-4 = "%{F${pink}}%{F-}"
      #menu-0-4-exec = loginctl lock-session

      #format =<menu>  <label-toggle>

      #label-open = "%{F${pink}}%{F-}"

      #label-close = "%{F${pink}}%{F-}"


      #label-separator = "  "

      #[settings]
      #screenchange-reload = true
      #pseudo-transparency = true

      #[global/wm]
      #margin-top = 0
      #margin-bottom = 0

      #[module/i3]
      #type = internal/i3
      #format = <label-state> <label-mode>
      #index-sort = true
      #wrapping-scroll = false

      #label-mode-padding = 2
      #label-mode-foreground = #000

      #label-focused = %index%
      #label-focused-background = ${pink}
      #label-focused-underline = ''${colors.primary}
      #label-focused-padding = 2

      #label-unfocused = %index%
      #label-unfocused-padding = 2

      #label-visible = %index%
      #label-visible-background = ''${self.label-focused-background}
      #label-visible-underline = ''${self.label-focused-underline}
      #label-visible-padding = ''${self.label-focused-padding}

      #label-urgent = %index%
      #label-urgent-background = ''${colors.alert}
      #label-urgent-padding = 2
    #'';
  #};
  #xsession.enable = true;
  #xsession.windowManager.i3 = {
    #enable = true;
    #config = null;
  #};
  #programs.rofi = {
    #package =
      #pkgs.rofi.override { plugins = with pkgs; [ rofi-calc rofi-emoji ]; };
    #enable = true;
    #extraConfig = {
      #modi = "combi,calc";
      #combi-modi = "drun,run,window,file-browser,ssh,keys,emoji";
    #};
    #font = "Cascadia Code 10";
    #colors = {
      #rows = {
        #normal = {
          #background = bg;
          #foreground = fg;
          #backgroundAlt = bg;
          #highlight = {
            #background = pink;
            #foreground = fg;
          #};
        #};

      #};
      #window = {
        #background = bg;
        #separator = pink;
        #border = pink;
      #};
    #};
  #};
}
