{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    displayManager = {
      lightdm = {
        enable = true;

        background = "/etc/wallpaper/wallpaper.png";

        greeters.gtk = {
          enable = true;
          theme = {
            package = pkgs.sierra-gtk-theme;
            name = "Sierra";
          };
          indicators = [ "~spacer" "~clock" "~spacer" "~session" "~power" ];
        };
      };
    };

    windowManager = { bspwm.enable = true; };

    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
      touchpad = {
        naturalScrolling = true;
        accelSpeed = "0.3";
        #accelProfile = "flat";
      };
    };
    config = ''
      Section "InputClass"
        Identifier "mouse accel"
        Driver "libinput"
        MatchIsPointer "on"
        Option "AccelProfile" "flat"
        Option "AccelSpeed" "0"
      EndSection
    '';
  };
}
