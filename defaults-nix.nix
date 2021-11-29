{ pkgs, config, lib, inputs, ... }:

let
  nur-packages = with pkgs.nur.repos; [
    devins2518.bunnyfetch-rs
    devins2518.gyro
    devins2518.zig-master
  ];
in {
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  environment = {
    homeBinInPath = true;
    sessionVariables = { NIXOS_CONFIG = "/home/devin/Repos/dotfiles"; };
    etc."wallpaper/wallpaper.png" = {
      source = pkgs.fetchurl {
        url =
          "https://raw.githubusercontent.com/manderio/manpapers/main/edited/devins2518/dark_road_upscaled_tokyonight.png";
        sha256 = "sha256-aebWDaDAG0wkOXLKrApbQkrrChzdrmi1Vn/JZV77nPw=";
      };
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      greeter = {
        group = "greeter";
        isSystemUser = true;
      };

      devin = {
        isNormalUser = true;
        hashedPassword =
          "$6$frNducsvL8EJ7hUe$P6PbYTwjzFpi9ZIPl2lczGlg4Lx5B0prno1STZe/mAo4h8zSPCSETzaBpQl0b911ujMFinaNG580o78ss6lIm.";
        shell = pkgs.zsh;
        description = "Devin Singh";
        extraGroups =
          [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
      };
    };
  };

  boot = {
    cleanTmpDir = true;
    kernelParams = [ "quiet" ];
    consoleLogLevel = 3;
  };

  security.sudo.wheelNeedsPassword = false; # wheel ALL=(ALL) NOPASSWD:ALL

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "root" "devin" ];

    generateRegistryFromInputs = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    nixPath = [ "nixpkgs=${pkgs.path}" "home-manager=${inputs.home-manager}" ];

    binaryCaches = [
      "https://cache.nixos.org?priority=10"
      "https://nix-community.cachix.org"
      "https://fortuneteller2k.cachix.org"
      "https://devins2518.cachix.org"
    ];

    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
      "devins2518.cachix.org-1:VQepMECpWpT95AjVOU30xz6kbrBRUMpHAOdKP/tulB0="
    ];
  };

  programs = {
    command-not-found.enable = false;
    dconf.enable = true;
  };

  nixpkgs.config = { allowUnfree = true; };
  environment.systemPackages = with pkgs;
    [
      aerc
      binutils.bintools
      bottom
      cachix
      cargo-tarpaulin
      clang
      clang-tools
      dunst
      ffmpeg
      firefox
      gcc
      ghc
      gnumake
      go
      gopls
      haskell-language-server
      helix-git
      hyperfine
      jq
      libllvm
      libnotify
      lldb
      llvm
      lm_sensors
      luaformatter
      meson
      ninja
      nixfmt
      nixpkgs-review
      ormolu
      pamixer
      pandoc
      pavucontrol
      pcmanfm
      ripgrep
      rnix-lsp
      rust-analyzer
      rustup
      stack
      sumneko-lua-language-server
      tokei
      tree
      unzip
      wget
      xarchiver
      xxd
      zls
      zsh
    ] ++ nur-packages;

  # Needed for home manager to not get borked
  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  console = { keyMap = "us"; };
  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
      font-awesome
      material-design-icons
      nur.repos.devins2518.iosevka-serif
      tenderness
      spleen
    ];
  };
}
