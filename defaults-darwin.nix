{ pkgs, config, lib, inputs, mkIf, ... }:

let
  inherit (lib)
    mkIf filterAttrs mapAttrs mapAttrsToList mapAttrs' mkOption types;
  filteredInputs = filterAttrs (n: _: n != "self") inputs;
  nixPathInputs = mapAttrsToList (n: v: "${n}=${v}") filteredInputs;
  registryInputs = mapAttrs (_: v: { flake = v; }) filteredInputs;

  nur-packages = with pkgs.nur.repos;
    [
      devins2518.bunnyfetch-rs
      #devins2518.gyro
      #devins2518.zig-master
    ];
in {
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  environment = {
    variables = {
      NIXOS_CONFIG = "/Users/devin/Repos/dotfiles";
      HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
      HOMEBREW_REPOSITORY = "/opt/homebrew";
    };
    systemPath = [ "/opt/homebrew/bin" ];
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "root" "devin" ];

    registry = registryInputs;

    gc = {
      automatic = true;
      user = "root";
      options = "--delete-older-than 7d";
    };

    #nixPath = { nixpkgs="${pkgs.path}"; home-manager="${inputs.home-manager}"; darwin="${inputs.darwin}"; };
    nixPath = nixPathInputs;

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

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };
  environment.systemPackages = with pkgs;
    [
      #binutils.bintools
      #gcc
      #libllvm
      #ormolu
      #zls
      iterm2
      bottom
      cachix
      cargo-tarpaulin
      clang
      clang-tools
      ffmpeg
      gnumake
      helix-git
      hyperfine
      jq
      lldb
      llvm
      luaformatter
      meson
      ninja
      nixfmt
      nixpkgs-review
      pandoc
      ripgrep
      rnix-lsp
      rust-analyzer
      rust-bin.stable.latest.default
      stack
      sumneko-lua-language-server
      tokei
      tree
      unzip
      wget
      xxd
      zsh
    ] ++ nur-packages;

  #homebrew = {
  #  enable = true;
  #  brewPrefix = "/opt/homebrew/bin";
  #  autoUpdate = true;
  #  cleanup = "zap";
  #  global = {
  #    brewfile = true;
  #    noLock = true;
  #  };

  #  taps = [ "homebrew/core" "homebrew/cask" ];

  #  casks = [ "iterm2" ];
  #};

  programs.gnupg.agent.enable = true;
  system.activationScripts.applications.text = pkgs.lib.mkForce (''
      echo "setting up /Applications/Nix..."
      rm -rf /Applications/Nix
      mkdir -p /Applications/Nix
      chown devin /Applications/Nix
      find ${config.system.build.applications}/Applications -maxdepth 1 -type l | while read f; do
        src="$(/usr/bin/stat -f%Y $f)"
        appname="$(basename $src)"
        osascript -e "tell app \"Finder\" to make alias file at POSIX file \"/Applications/Nix/\" to POSIX file \"$src\" with properties {name: \"$appname\"}";
    done
  '');

  fonts = {
    enableFontDir = true;
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