{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    displayManager = {
      session = [{
        manage = "desktop";
        name = "xsession";
        start = "exec $HOME/.xsession";
      }];

      lightdm = {
        enable = true;

        background = "/etc/wallpaper/wallpaper.png";

        greeters.gtk = {
          enable = true;
          theme = {
            name = "WhiteSur-dark-alt-purple";
            package = pkgs.whitesur-gtk-theme;
          };
          indicators = [ "~spacer" "~clock" "~spacer" "~session" "~power" ];
        };
      };
    };

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
