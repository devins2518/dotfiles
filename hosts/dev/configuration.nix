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
    kernelParams = [ "quiet" ];
    consoleLogLevel = 3;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot"; # ← use the same mount point here.
      };
      grub = {
        enable = true;
        devices = [ "nodev" ];
        default = "saved";
        version = 2;
        efiSupport = true;

        extraEntries = ''
          menuentry "Windows" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root F5F4-286C
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';

        extraConfig = ''
          GRUB_SAVEDEFAULT=true

          if [ "x\''${timeout}" != "x-1" ]; then
            if keystatus; then
              if keystatus --shift; then
                set timeout=-1
              else
                set timeout=0
              fi
            else
              if sleep --interruptible ''${GRUB_HIDDEN_TIMEOUT} ; then
                set timeout=0
              fi
            fi
          fi
        '';
      };
    };
  };

  networking = {
    hostName = "dev";
    interfaces.enp5s0.useDHCP = true;
    interfaces.wlp4s0.useDHCP = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    screenSection = ''
      DefaultDepth    24
      Option         "Stereo" "0"
      Option         "nvidiaXineramaInfoOrder" "DFP-2"
      Option         "metamodes" "1920x1080_144 +0+0"
      Option         "SLI" "Off"
      Option         "MultiGPU" "Off"
      Option         "BaseMosaic" "off"
      SubSection     "Display"
          Depth       24
      EndSubSection
    '';
    deviceSection = ''
      VendorName     "NVIDIA Corporation"
      BoardName      "GeForce GTX 1660 SUPER"
      Option         "Coolbits" "4"
    '';
    monitorSection = ''
      VendorName     "Unknown"
      ModelName      "AUS ASUS VP249"
      HorizSync       180.0 - 180.0
      VertRefresh     48.0 - 144.0
      Option         "DPMS"
    '';
    inputClassSections = [''
      Identifier "mouse accel"
      Driver "libinput"
      MatchIsPointer "on"
      Option "AccelProfile" "flat"
      Option "AccelSpeed" "0"
    ''];
    exportConfiguration = true;
    displayManager.lightdm.greeters.gtk.cursorTheme.size = 16;
  };

  environment.systemPackages = with pkgs; [ gimp minicom nvfancontrol cachix ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    cpu.amd.updateMicrocode = true;
    opengl = { enable = true; };
  };

  console = { font = "${pkgs.spleen}/share/consolefonts/spleen-8x16.psfu"; };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
