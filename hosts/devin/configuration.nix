# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the GRUB boot loader.
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot"; # ← use the same mount point here.
      };
      grub = {
        enable = true;
        devices = [ "nodev" ];
        version = 2;
        # Doesn't work?
        font = "${pkgs.grub2}/share/grub/unicode.pf2";
        fontSize = 16;
        efiSupport = true;

        extraEntries = ''
          menuentry "Windows" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root 3087-B4EC
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';

        # extraConfig = ''
        #   if keystatus --shift ; then
        #       set timeout=-1
        #   else
        #       set timeout=0
        #   fi
        # '';
      };
    };
  };

  networking = {
    hostName = "devin";
    interfaces.wlp2s0.useDHCP = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    videoDrivers = [ "intel" ];
    deviceSection = ''
      Option "TearFree" "true"
    '';
    wacom.enable = false;
    dpi = 192;
    layout = "us";
    displayManager.lightdm.greeters.gtk.cursorTheme.size = 32;
  };

  systemd = {
    services.iptsd.enable = false;
    sleep.extraConfig = ''
      AllowSuspend=yes
      AllowHibernation=yes
      AllowSuspendThenHibernate=yes
      HibernateDelaySec=1h
    '';
  };

  # check config_hz in /proc/config.gz
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    acpilight.enable = true;
    video.hidpi.enable = true;
    cpu.intel.updateMicrocode = true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  services.upower = { enable = true; };

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=suspend
  '';

  nixpkgs.config = { allowUnfree = true; };
  # List packages installed in system profile.
  environment = {
    variables = {
      # GDK_SCALE = "2";
      # GDK_DPI_SCALE = "0.5";
      # _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
      # Doesn't work?
      XCURSOR_SIZE = "24px";
    };
  };

  #  fonts = { fontconfig.dpi = 192; };

  console = { font = "${pkgs.spleen}/share/consolefonts/spleen-16x32.psfu"; };

  nix = { maxJobs = 4; };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
