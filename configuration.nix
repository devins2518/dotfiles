# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the GRUB boot loader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
    grub = {
      devices = [ "nodev" ];
      enable = true;
      version = 2;
      # Doesn't work?
      # fontSize = 16;
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
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable =
    true; # Enables wireless support via Network Manager

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Doesn't work?
    # wacom.enable = true;
    videoDrivers = [ "intel" ];
    deviceSection = ''
      Option "DRI" "2"
      Option "TearFree" "true"
    '';
    dpi = 192;

    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+awesome";
    };

 windowManager = {

        awesome = {

          package = (pkgs.awesome.overrideAttrs (old: rec {
            version = "a4572b9b52d89369ce3bd462904d536ec116dc35";
            src = pkgs.fetchFromGitHub {
              owner = "awesomeWM";
              repo = "awesome";
              rev = "a4572b9b52d89369ce3bd462904d536ec116dc35";
              sha256 = "1kj2qz2ns0jn5gha4ryr8w8vvy23s3bb5z3vjhwwfnrv7ypb40iz";
            };
            GI_TYPELIB_PATH = "${pkgs.playerctl}/lib/girepository-1.0:" + old.GI_TYPELIB_PATH;
          })).override {
            stdenv = pkgs.clangStdenv;
            luaPackages = pkgs.lua52Packages;
            gtk3Support = true;
          };

          enable = true;

          luaModules = with pkgs.lua52Packages; [
            lgi
            ldbus
            luarocks-nix
            luadbi-mysql
            luaposix
          ];

        };};
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages;
        [
          luarocks # is the package manager for Lua modules
        ];

    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput = {
      enable = true;

      touchpad = {
        naturalScrolling = true;
        accelSpeed = "1.0";
        accelProfile = "flat";
        # Doesn't work?
        # calibrationMatrix = "1.6 0 0 0 1.6 0 0 0 1";
      };
    };

    layout = "us";
  };

  # Breaks wifi
  nix.maxJobs = 4;
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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
  };};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.devin = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Devin Singh";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  security.sudo.wheelNeedsPassword = false; # wheel ALL=(ALL) NOPASSWD:ALL

  # List packages installed in system profile.
  nixpkgs.config = { allowUnfree = true; };
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];
  environment.systemPackages = with pkgs; [
    alacritty
    firefox
    rustup
    git
    discord
    nixfmt
    home-manager
    zsh-powerlevel10k
    lm_sensors
    # p10k isn't available for some reason
  ];

  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    # Doesn't work?
    XCURSOR_SIZE = "32";
  };

  programs.zsh = {
    enable = true;
    histSize = 2000;
    histFile = "~/.zsh/HIST";

    autosuggestions = {
      enable = true;
      strategy = "match_prev_cmd";
    };

    syntaxHighlighting.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.tmux = { enable = true; };

  fonts = {
    fontconfig.dpi = 192;

    fonts = with pkgs;
      [ (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; }) ];
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

