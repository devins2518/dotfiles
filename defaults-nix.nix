{ pkgs, config, lib, inputs, ... }:

let
  caches = [
    "https://devins2518.cachix.org"
    "https://cache.nixos.org"
    "https://neovim-nightly.cachix.org"
    "https://nix-community.cachix.org"
  ];
  gyro = pkgs.callPackage ./overlays/gyro.nix { };
in {
  #age.secrets.variables = {
  #file = ./secrets/variables.age;
  #owner = "nix";
  #mode = "0700";
  #};
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  #age.secrets.variables = {
  #file = ./secrets/variables.age;
  #owner = "nix";
  #mode = "0700";
  #};

  environment = {
    sessionVariables = { NIXOS_CONFIG = "/home/devin/Repos/dotfiles"; };
    shellAliases = {
      nix-repl = "nix repl ${inputs.utils.lib.repl}";
      nshell = "nix-shell";
      ls = "ls -l --color=always";
    };
    etc."spaceman.png" = {
      source = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/ox/wallhaven-oxkjgm.jpg";
        sha256 = "sha256-k5lZlGipd1dpOLCBXtOQ58sHxvTH81COTMg/XKuxb6Y=";
      };
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.devin = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Devin Singh";
      extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    };
  };

  security.sudo.wheelNeedsPassword = false; # wheel ALL=(ALL) NOPASSWD:ALL

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "root" "devin" ];

    maxJobs = 4;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # TODO
    binaryCaches = caches;

    binaryCachePublicKeys = [
      "devins2518.cachix.org-1:R0BYXkgRm24m+gHUlYzrI2DxwNEOKWXF1/VdYSPCXyQ="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "neovim-nightly.cachix.org-1:feIoInHRevVEplgdZvQDjhp11kYASYCE2NGY9hNrwxY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    trustedBinaryCaches = caches;

    nixPath = [ "nixpkgs=${pkgs.path}" "home-manager=${inputs.home-manager}" ];
  };

  programs = {
    command-not-found.enable = false;
    zsh = {
      enable = true;
      histSize = 2000;
      histFile = "$HOME/.zsh/HISTFILE";
    };
  };

  nixpkgs.config = { allowUnfree = true; };
  environment.systemPackages = with pkgs; [
    zls
    zig
    rnix-lsp
    firefox
    rustup
    discord
    nixfmt
    home-manager
    lm_sensors
    rofi
    pcmanfm
    xdotool
    polybar
    alttab
    feh
    gcc
    picom
    #gnomeExtensions.dash-to-dock
    dunst
    bottom
    go
    tokei
    cachix
    gyro
    nixpkgs-review
  ];

  # Needed for home manager to not get borked
  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "JetBrainsMono" ]; })
      font-awesome
      scientifica
    ];
  };
}
