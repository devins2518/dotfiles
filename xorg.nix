{ config, pkgs, ... }:

{
  environment = { systemPackages = with pkgs; [ xclip xdotool maim ]; };

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
          cursorTheme = {
            name = "Quintom_Ink";
            package = pkgs.quintom-cursor-theme;
          };
          indicators = [ "~spacer" "~clock" "~spacer" "~session" "~power" ];
          clock-format = "%I:%M";
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
