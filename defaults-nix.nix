{ pkgs, config, lib, inputs, ... }:

let
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
      zig-flake = ''
        echo '{
          inputs = {
            nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
            utils.url = "github:numtide/flake-utils";
            zig.url = "github:arqv/zig-overlay";
          };
      
          outputs = { self, nixpkgs, utils, zig }:
            utils.lib.eachDefaultSystem (system:
              let
                pkgs = nixpkgs.legacyPackages."''${system}";
              in {
               devShell = pkgs.mkShell {
                  nativeBuildInputs = [
                    zig.packages."''${system}".master.latest
                  ];
                };
              });
        }' >> flake.nix
        echo 'use flake' >> .envrc
        direnv allow
        echo '*~
        *.swp
        zig-cache/
        zig-out/
        answers/
        patches/healed/

        .direnv/*
        !.direnv/.git-keep

        .gyro/' >> .gitignore
      '';
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
    gyro
    nixpkgs-review
    xarchiver
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
