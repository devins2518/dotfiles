{ pkgs, config, lib, inputs, ... }:

let
  gyro = pkgs.callPackage ./overlays/gyro.nix { };
in {
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  environment = {
    homeBinInPath = true;
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
    alttab
    bottom
    bsp-layout
    bunnyfetch
    discord
    dunst
    feh
    firefox
    gcc
    go
    gopls
    gyro
    luaformatter
    lm_sensors
    nixfmt
    nixpkgs-review
    pcmanfm
    picom
    polybar
    rnix-lsp
    rofi
    rust-analyzer
    rustup
    stlink
    tokei
    xarchiver
    xdotool
    zig
    #zls
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
