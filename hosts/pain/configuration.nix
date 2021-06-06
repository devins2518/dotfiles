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
    consoleLogLevel = 3;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot"; # ← use the same mount point here.
      };
      grub = {
        devices = [ "nodev" ];
        enable = true;
        version = 2;
        efiSupport = true;
      };
    };
  };

  networking = {
    hostName = "pain";
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
  };

  environment.systemPackages = with pkgs; [
    nvfancontrol
  ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    cpu.amd.updateMicrocode = true;
    opengl = { enable = true; };
  };

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "JetBrainsMono" ]; })
      font-awesome
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}

